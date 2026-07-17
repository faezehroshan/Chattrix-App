const mongoConnector = require('./../db/mongo-connector')

const getLatestOfflineMessage = async (userId) => {
    
    const database = await mongoConnector()
    const dbo = database.db(process.env.DB_NAME) 

    
    try {
        return await dbo.collection("messages_" + userId)
            .aggregate([{
                    $lookup: {
                        from: 'users',
                        localField: 'fromId',
                        foreignField: '_id',
                        as: 'user'
                    }
                },
                {
                    $project: {
                        'message': 1,
                        'dateTime': 1,
                        'user._id': 1,
                        'user.fullname': 1,
                        'user.username': 1
                    }
                }
            ])
            .toArray();
    } catch (er) {
        console.log(er)
        return null
    }

}

module.exports = getLatestOfflineMessage