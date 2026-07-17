import 'package:chat/constants/colors.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/pages/messages/chat_tab_view.dart';
import 'package:chat/pages/messages/messages_get.dart';
import 'package:chat/pages/messages/messages_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> with TickerProviderStateMixin {
  TabController? _controller;
  final messagesGet = Get.put(MessagesGet());

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.secColor,
        title: const Text('MESSAGES'),
        leading: IconButton(
          onPressed: () => Get.toNamed(PageRoutes.settings),
          icon: const Icon(CupertinoIcons.line_horizontal_3_decrease, color: MyColors.btnColor),
        ),
    
      ),
      body: Column(
        children: [
          MessagesTabbar(controller: _controller!),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [ChatTabView(), ChatTabView()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
       shape: CircleBorder(),
        backgroundColor: MyColors.chatColor,
        onPressed: () => messagesGet.addContact(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
