const mongoConnector = require('./../db/mongo-connector');
const jwt = require("jsonwebtoken");
const bcryptjs = require("bcryptjs");

const jwtKey = process.env.JWT_KEY;
const jwtSeconds = process.env.JWT_SEC;

const register = async (req, res) => {
    try {

        const { fullname, username, password } = req.body || {};

    
        if (!fullname || !username || !password) {
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

    
        const saltRounds = parseInt(process.env.SALT) || 10;
        const saltyPass = await bcryptjs.hash(password, saltRounds);

       
        const existingUser = await collection.findOne({ username });

        if (existingUser) {
           
            return res.status(400).json({
                message: "This username is already taken",
                error_code: "user_exist"
            });
        }

       
   
        const token = jwt.sign(
            { username },
            jwtKey,
            {
                algorithm: 'HS256',
                expiresIn: jwtSeconds
            }
        );

    
        const user = {
            fullname: fullname,
            username: username,
            password: saltyPass,
            token: token,
            createdAt: new Date()
        };

        const result = await collection.insertOne(user);
     


    
        return res.status(200).json({
            message: "User registered successfully",
            error_code: "success",
            data: {
                id: result.insertedId,
                fullname: user.fullname,
                username: user.username,
                token: token
            }
        });

    } catch (error) {
        console.error(' Register error:', error);
        if (error.message.includes('Mongo')) {
            return res.status(500).json({
                message: "Database connection error",
                error_code: "db_error",
                details: error.message
            });
        }

        return res.status(500).json({
            message: "Internal server error",
            error_code: "server_error",
            details: error.message
        });
    }
};

module.exports = register;