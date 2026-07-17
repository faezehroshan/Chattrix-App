require('dotenv').config()
const express = require('express')
const bodyParser = require('body-parser')
const http = require('http') 
const SocketUser = require('./models/user_socket');
const app = express()
const server = http.createServer(app)
const io = require('socket.io')(server)

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

const multer = require('multer')
const uploadMiddleWare = multer({
  dest: process.env.MULTER_TEMP_PATH
})


const users = []
const port = process.env.PORT || 3000
const registerService = require("./services/register")
const signInService = require("./services/signIn")
const clearService = require("./services/clear")
const newContactService = require("./services/new_contact")
const getUserIdservice = require("./services/getUserIdFromToken")
const tokenFresher = require("./services/tokenFresher")
const sendMessageOffline = require("./services/sendMessageOffline")
const getOfflineMessageService = require("./services/get_offline_messages")
const clearLatestOfflineMessageService = require("./services/clear_latest_offline_message")
const aploadAvatarService = require("./services/upload_avatar")
const showAvatarService = require("./services/show_avatar")
io.on("connection",async(socket) =>{
 const socketId = socket.id
 const token = socket.handshake.query.token
 const checkToken = await getUserIdservice(token)

if (!checkToken || !checkToken.data) {
  console.log("Invalid socket token")
  socket.disconnect()
  return
}

const user = new SocketUser({socketId: socketId, userId: checkToken.data._id,
   username: checkToken.data.username,
 token: token, fullname: checkToken.data.fullname})

 const index = users.findIndex(
  u => u.userId.toString() === user.userId.toString()
);

if (index !== -1) {
  users.splice(index, 1);
}
users.push(user)

socket.on("join-room" , (event)=>{
  socket.join(`RoomId::${event.roomId}`)
  console.log(`user ${user.userId} join to ${event.roomId}`)
})

socket.on("leave-room" , (event)=>{
  socket.leave(`RoomId::${event.roomId}`)
  console.log(`user ${user.userId} left to ${event.roomId}`)
})


socket.on("send-message",(event)=>{

  if(!!event.roomId){
    io.to(`RoomId::${event.roomId}`).emit("onMessage", { 'message': event.message,
        'from': user,
     'roomId': event.roomId})
  }else{

     console.log(`user ${user.userId} send message to ${event.to} > ${event.message}`)
   
    const fillteredUser = users.filter((elem)=>elem.userId == event.to)
    if(fillteredUser.length > 0){
  const receiverSocketId = fillteredUser[0].socketId
    socket.broadcast.to(receiverSocketId).emit("onMessage",{
        'message': event.message,
        'from': user
    })
     console.log(`user ${user.userId} sent a message > ${event.message}`)
    }else{
      sendMessageOffline(user.userId , event.to,event.message).then(result => {
        if(result.data.status){
           console.log(`user ${user.userId} sent a offline message to ${event.to} > ${event.message}`)
        }
      })
    }
  
  }

})
if (!checkToken || !checkToken.data) {
  console.log("Invalid socket token", token)
  socket.disconnect()
  return
}
 socket.on("disconnect", (event)=>{
      const index = users.findIndex(
        u => u.socketId === socket.id
    );

    if (index !== -1) {
        users.splice(index, 1);
    }
  console.log(`user ${user.userId} disconnected`)

 })
})

app.get('/', (req, res)=>{
    res.send("<h1>Hello</h1>")
})


app.post('/register', registerService)
app.post('/signin', signInService)
app.post('/new-contact', newContactService)
app.post('/refresh-token', tokenFresher)
app.post('/get-latest-offline-message', getOfflineMessageService)
app.post('/clear-latest-offline-message', clearLatestOfflineMessageService)
app.get('/clearUsers', clearService)
app.put('/upload-avatar', uploadMiddleWare.single('avatar'), aploadAvatarService)
app.get('/avatar/:userId', showAvatarService)




server.listen(port,()=>{
    console.log(`server is runnig on port ${port}`)
})