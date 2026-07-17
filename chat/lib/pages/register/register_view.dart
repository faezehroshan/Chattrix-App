
import 'package:chat/components/buttons/primary_buttons.dart';
import 'package:chat/components/buttons/underline_buttons.dart';
import 'package:chat/components/loading.dart';
import 'package:chat/components/textfields/primary_textfield.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/pages/register/register_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final registerGet = RegisterGet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.secColor,
        title: const Text('Register' ),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back , color: MyColors.btnColor),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 100, top: 100),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: MyColors.chatColor,
                  child: Icon(CupertinoIcons.person_add,
                      size: 80, color: MyColors.secColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    PrimaryTextfield(
                      prefixIcon: CupertinoIcons.person_crop_circle,
                      maxLength: 30,
                      hint: 'Enter Full name',
                      onChanged: (newVal) =>
                          registerGet.fullname.value = newVal,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: PrimaryTextfield(
                        hint: 'Enter Username',
                        prefixIcon: CupertinoIcons.person,
                        onChanged: (newVal) =>
                            registerGet.username.value = newVal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: PrimaryTextfield(
                        hint: 'Enter Password',
                        isPassword: true,
                        prefixIcon: CupertinoIcons.lock,
                        onChanged: (newVal) =>
                            registerGet.password.value = newVal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Obx(() => registerGet.loading.value
                          ? MyLoading()
                          : PrimaryButton(
                              title: 'Create New Account',
                              onPressed: registerGet.createNewAccount)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: UnderlineButton(
                          title: 'You already registered?', onPressed: () {}),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}