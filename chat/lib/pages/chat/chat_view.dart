import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/constants/text_style.dart';
import 'package:chat/pages/chat/chat_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);

  final chatGet = Get.put(ChatGet());
  final avatarVersion = DateTime.now().millisecondsSinceEpoch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(49, 44, 81, 1),
        title: CupertinoButton(
          color: MyColors.secColor,
          padding: EdgeInsets.zero,
          onPressed: chatGet.userInfo,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: MyColors.backColor,
                  child: ClipOval(
                   
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Obx(
                        () => CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              Config.showAvatar(chatGet.contactRx.value?.user.id , version: avatarVersion,),
                          errorWidget: (context, url, error) => Icon(
                            
                            Icons.person,
                            color: MyColors.chatColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                chatGet.user?.fullname ?? '',
                style: MyTextStyles.button.copyWith(color: MyColors.btnColor),
              ),
            ],
          ),
        ),
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back , color: MyColors.btnColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            StreamBuilder<bool>(
              stream: chatGet.onUpdateStream.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                  controller: chatGet.scrollController,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 150),
                  itemCount: chatGet.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatGet.messages[index];
                    final isMyMessage = message.isMyMessage();
        
                    return chatBubble(isMyMessage, message);
                  },
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                 
                  border: Border(
                    top: BorderSide(width: 0.3, color:MyColors.btnColor, ),
                  ),
                ),
                child: SafeArea(
                  
                  child: Container(
                    color: MyColors.secColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: MyColors.btnColor,
                        controller: chatGet.controller,
                        onChanged: (value) =>
                            chatGet.message.value = value,
                        minLines: 1,
                        maxLines: 8,
                        style: MyTextStyles.textfield.copyWith(
                          fontWeight: FontWeight.bold,
                          
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write a message...',
                          hintStyle: TextStyle(
                            color: MyColors.btnColor,
                           
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Obx(
                            () => IconButton(
                              onPressed: chatGet.message.value.isEmpty
                                  ? null
                                  : chatGet.send,
                              icon: Icon(
                                Icons.send_rounded,
                                color: chatGet.message.value.isEmpty
                                    ? MyColors.btnColor
                                    : MyColors.chatColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatBubble(bool isMyMessage, dynamic message) => ChatBubble(
        backGroundColor:
            isMyMessage ? MyColors.chatColor : MyColors.btnColor,
        margin: isMyMessage
            ? const EdgeInsets.only(bottom: 10, right: 20)
            : const EdgeInsets.only(bottom: 10, left: 20),
        padding: isMyMessage
            ? const EdgeInsets.only(
                left: 10,
                right: 20,
                top: 10,
                bottom: 10,
              )
            : const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 10,
                bottom: 10,
              ),
        clipper: ChatBubbleClipper4(
          type: isMyMessage
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble,
          radius: 10,
        ),
        alignment:
            isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          message.message,
          style: MyTextStyles.chat,
        ),
      );
 }