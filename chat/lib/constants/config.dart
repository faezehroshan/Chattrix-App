import 'package:chat/constants/colors.dart';
import 'package:chat/constants/text_style.dart';
import 'package:chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Config {
  Config._();

  static const httpsServicesBaseUrl = 'http://10.0.3.2:8888';
  static const socketServerBaseUrl = 'http://10.0.3.2:8888';

  static UserModel? userModel;

  static void errorHandler({String title = '', String error = ''}) {
    Get.snackbar(
      title,
      error,
      backgroundColor: MyColors.secColor,
      colorText: MyColors.chatColor,
      duration: Duration(seconds: 4),
    );
  }

 static String showAvatar(String? userId, {int? version}) {
  final url = "${Config.httpsServicesBaseUrl}/avatar/$userId";

  if (version != null) {
    return "$url?v=$version";
  }

  return url;
}





  static ThemeData primaryThemeData = ThemeData(
   primaryColor: MyColors.backColor,
    fontFamily: 'Nexa',
    scaffoldBackgroundColor: MyColors.backColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MyColors.secColor,
      enabledBorder: OutlineInputBorder(
      //
      //  borderSide: const BorderSide(color: Colors.grey, width: 1),
      borderSide:BorderSide.none,
      borderRadius: BorderRadius.circular(8),
      ),
      focusColor: MyColors.btnColor,
      iconColor: MyColors.btnColor,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide( 
          
          color: MyColors.btnColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    appBarTheme: const AppBarTheme(
      toolbarHeight: 68,
      
      iconTheme: IconThemeData(color: Colors.black, size: 24),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: MyTextStyles.appbar,
    ),
  );

  static String showAvatarBaseUrl(String? id) {
    return "${Config.httpsServicesBaseUrl}/avatar/$id";
  }
}

class PageRoutes {
  PageRoutes._();

  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String signIn = '/sign-in';
  static const String messages = '/messages';
  static const String settings = '/settings';
  static const String splash = '/splash';
  static const String chat = '/chat';
  static const String roomProperties = '/room-properties';
  static const String contactProperties = '/contact-properties';
}
