import 'package:chat/constants/config.dart';
import 'package:chat/models/contact_model.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/models/new_user_model.dart';
import 'package:chat/pages/chat/chat_view.dart';
import 'package:chat/pages/login/login_view.dart';
import 'package:chat/pages/messages/messages_view.dart';
import 'package:chat/pages/register/register_view.dart';
import 'package:chat/pages/setting/setting_view.dart';
import 'package:chat/pages/splash/splash_view.dart';
import 'package:chat/pages/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await GetStorage.init();
  await Hive.initFlutter();
   Hive.registerAdapter(NewUserModelAdapter());
   Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(ContactModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'chat',
        theme: Config.primaryThemeData,
        initialRoute: PageRoutes.splash,
        getPages: [
          GetPage(name: PageRoutes.welcome, page: () => Welcome()),
          GetPage(name: PageRoutes.register, page: () => Register()),
          GetPage(name: PageRoutes.signIn, page: () => Login()),
          GetPage(name: PageRoutes.messages, page: () => Messages()),
          GetPage(name: PageRoutes.splash, page: () => SplashView()),
          GetPage(name: PageRoutes.chat, page: () => Chat()),
          GetPage(name: PageRoutes.settings, page: () => SettingView())
        ],
      ),
    );
  }
}
