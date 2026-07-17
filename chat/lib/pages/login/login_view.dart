import 'package:chat/components/buttons/primary_buttons.dart';
import 'package:chat/components/buttons/underline_buttons.dart';
import 'package:chat/components/loading.dart';
import 'package:chat/components/textfields/primary_textfield.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/pages/login/login_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final loginGet = LoginGet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.secColor,
        title: const Text('Sign In'),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back , color: MyColors.btnColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: CircleAvatar(
                radius: 60,
                backgroundColor:  MyColors.chatColor,
                child: Icon(CupertinoIcons.lock_shield,
                    size: 80, color: MyColors.secColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  PrimaryTextfield(
                    hint: 'Enter Username',
                    prefixIcon: CupertinoIcons.person,
                    onChanged: (newVal) => loginGet.username.value = newVal,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: PrimaryTextfield(
                      hint: 'Enter Password',
                      isPassword: true,
                      prefixIcon: CupertinoIcons.lock,
                      onChanged: (newVal) => loginGet.password.value = newVal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Obx(() => loginGet.loading.value
                        ? const MyLoading()
                        : PrimaryButton(
                            title: 'Sign In',
                            onPressed: loginGet.loginToAccount)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: UnderlineButton(
                        title: 'Forgot password?', onPressed: () {}),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}