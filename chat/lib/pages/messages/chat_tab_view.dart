import 'package:chat/components/message_widget.dart';
import 'package:chat/pages/messages/messages_get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTabView extends StatelessWidget {
   ChatTabView({super.key});
  final  messageGet = Get.find<MessagesGet>();
  @override
  Widget build(BuildContext context) {
    return Container(
     child: StreamBuilder(stream: messageGet.contactSteam.stream,
     builder:(context, snapshot) => ListView.builder(
      itemBuilder: (context, index) =>MessageWidget(contact: messageGet.contacts[index]) ,
      itemCount: messageGet.contacts.length),),


    );
  }
}
