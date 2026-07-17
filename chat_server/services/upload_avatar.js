const path = require('path')
const fs = require('fs')
const jwt = require('jsonwebtoken')
const jwtKey = process.env.JWT_KEY

const uploadAvatar = async (req, res) => {
    const token = req.headers.authorization
    const userId = req.headers.userid

    if (userId == "" || userId == undefined) {
        res.status(400).json({
            message: 'Please send a user id!',
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

       try{
            jwt.verify(token.replace('Bearer ' , ''),jwtKey)
           }catch(err){
            res.status(400).json({
            message: 'Authentication not found!',
            error_code: 'failed',
            data: null
        })
           return 
           }


    const tempPath = req.file.path
    const targetPath = path.join(__dirname, `../${process.env.MULTER_TARGET_PATH}/${userId}.jpg`)

    fs.rename(tempPath, targetPath, (er) => {
        if (er) {
            console.log(er)
            res.status(400).json({
                message: er,
                error_code: 'upload_failed',
                data: null
            })
            return
        } else {
            fs.unlink(tempPath, () => {})
            res.status(200).json({
                message: 'File uploaded successfully',
                error_code: 'success',
                data: null
            })
            return
        }
    })

}

module.exports = uploadAvatar