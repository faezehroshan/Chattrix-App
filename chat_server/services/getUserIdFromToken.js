const mongoConnector = require('./../db/mongo-connector');
const jwt = require("jsonwebtoken");
const { ObjectId } = require('mongodb');

const jwtKey = process.env.JWT_KEY;

async function getUserIdFromToken(token) {
    try {

        let decoded;

        try {
            decoded = jwt.verify(token, jwtKey);
        } catch (err) {
            console.log(err);
            return null;
        }

        const db = await mongoConnector();
        const dbo = db.db(process.env.DB_NAME);
        const collection = dbo.collection("users");

        const user = await collection.findOne({
              username: decoded.username
        });

        if (!user) {
            console.log('User not found');
            
            return null;
        }

    

        return {
            message: "Authenticated successfully",
            error_code: "success",
            data: {
                _id: user._id,
                fullname: user.fullname,
                username: user.username,
            }
        };

    } catch (error) {
        console.error('get userid error:', error);
        return null;
    }
}

module.exports = getUserIdFromToken;