const mongoConnector = require('./../db/mongo-connector');
const jwt = require("jsonwebtoken");
const bcryptjs = require("bcryptjs");
const jwtKey = process.env.JWT_KEY;
const jwtSeconds = process.env.JWT_SEC;

const signIn = async (req, res) => {
    try {
        const { username, password } = req.body || {};

        if (!username || !password) {
            return res.status(400).json({
                message: "Please send all the values",
                error_code: "required_fields"
            });
        }

        if (password.length < 6) {
            return res.status(400).json({
                message: "Password must be at least 6 characters",
                error_code: "weak_password"
            });
        }
        const db = await mongoConnector();
        const dbo = db.db(process.env.DB_NAME);
        const collection = dbo.collection("users");
        const user = await collection.findOne({ username });

  
        if (!user) {
            console.log(' User not found');
       
            return res.status(400).json({
                message: "Your username or password is invalid",
                error_code: "invalid_user_pass"
            });
        }

        const isPasswordValid = await bcryptjs.compare(password, user.password);

        if (!isPasswordValid) {
            console.log(' Invalid password');
          
            return res.status(400).json({
                message: "Your username or password is invalid",
                error_code: "invalid_user_pass"
            });
        }

        const token = jwt.sign(
            { username: user.username },
            jwtKey,
            {
                algorithm: 'HS256',
                expiresIn: jwtSeconds
            }
        );

        const updateResult = await collection.updateOne(
            { username: username },
            { $set: { token: token } }
        );


     

        return res.status(200).json({
            message: "You are signed in now",
            error_code: "success",
            data: {
                _id: user._id,
                fullname: user.fullname,
                username: user.username,
                token: token
            }
        });

    } catch (error) {
        console.error(' SignIn error:', error);
        return res.status(500).json({
            message: "Internal server error",
            error_code: "server_error",
            details: error.message
        });
    }
};

module.exports = signIn;