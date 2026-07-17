const  MongoClient  = require('mongodb').MongoClient
const jwt = require("jsonwebtoken")
const jwtKey=process.env.JWT_KEY
const jwtSeconds = process.env.JWT_SEC
const bcryptjs = require("bcryptjs")


const clear = (req, res)=>{

MongoClient.connect(process.env.MONGO_URL, function(err, db){
 const dbo = db.db(process.env.DB_NAME)
    if(err) console.log(err)
dbo.collection("users").drop()
res.status(200).json({
    message:"Users is clear",
    error_code: "success",
})
})

}

module.exports = clear