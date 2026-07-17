import 'package:chat/components/buttons/primary_buttons.dart';
import 'package:chat/components/buttons/underline_buttons.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [_logo, _title],
            ),
            _buttons
          ],
        ),
      ),
    );
  }

  Widget get _title => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to',
              style: MyTextStyles.caption,
            ),
            Text(
              'ChatApp',
              style: MyTextStyles.header,
            ),
          ],
        ),
      );

  Widget get _logo => Center(
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(30),
          child: Container(
           decoration: BoxDecoration(
            color: MyColors.secColor),
            width: 130,
            height: 130,
            child: Icon(
              Icons.chat_bubble_outline_sharp, size: 90, color: MyColors.chatColor),
          ),
        ),
      );

  Widget get _buttons => Column(
        children: [
          PrimaryButton(
              title: 'Sign In',
              onPressed: () => Get.toNamed(PageRoutes.signIn)),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: UnderlineButton(
                title: 'Create new account?',
                onPressed: () => Get.toNamed(PageRoutes.register)),
          ),
        ],
      );
}