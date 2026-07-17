const mongoConnector = require('./../db/mongo-connector')
const jwt = require('jsonwebtoken')
const jwtKey = process.env.JWT_KEY

const newContact = async (req, res) => {
    const token = req.headers.authorization
    const username = req.body.username

    if (username == undefined) {
        res.status(400).json({
            message: 'Please send a username!',
            error_code: 'failed',
            data: null
        })
        return
    }

    if (token == undefined) {
        res.status(400).json({
            message: 'Authentication not found!',
            error_code: 'failed',
            data: null
        })
        return
    }

    try {
        jwt.verify(token.replace('Bearer ', ''), jwtKey)
    } catch (er) {
        res.status(400).json({
            message: 'Authentication failed',
            error_code: 'failed',
            data: null
        })
        return
    }
   const db = await mongoConnector();
   const dbo = db.db(process.env.DB_NAME);
   const collection = dbo.collection("users");
   const newUser = await collection.findOne({ username: username });

        if (!newUser) {
            console.log(' User not found');
           
            return res.status(400).json({
                message: "This username isn't available",
                error_code: "user_not_found"
            });
        }

        return res.status(200).json({
            message: "User found",
            error_code: "success",
            data: {
                _id: newUser._id,
                fullname: newUser.fullname,
                username: newUser.username,
               
            }
        });

}

module.exports = newContact