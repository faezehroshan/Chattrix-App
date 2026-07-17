const jwt = require('jsonwebtoken');
const jwtKey = process.env.JWT_KEY;

const getLatestOfflineMessage = require('./get_latest_offline_message');

const getOfflineMessages = async (req, res) => {
    const token = req.headers.authorization;
    const userId = req.body.userId;

    if (!userId) {
        return res.status(400).json({
            message: 'Please send a userId!',
            error_code: 'failed',
            data: null
        });
    }

    if (!token) {
        return res.status(401).json({
            message: 'Authentication not found!',
            error_code: 'failed',
            data: null
        });
    }

    try {
        jwt.verify(token.replace('Bearer ', ''), jwtKey);
    } catch (err) {
        return res.status(401).json({
            message: 'Authentication failed!',
            error_code: 'failed',
            data: null
        });
    }

    try {
        const messages = await getLatestOfflineMessage(userId);

        return res.status(200).json({
            message: 'Success',
            error_code: 'success',
            data: messages ?? []
        });
    } catch (err) {
        console.log(err);

        return res.status(500).json({
            message: err.toString(),
            error_code: 'failed',
            data: null
        });
    }
};

module.exports = getOfflineMessages;