import 'dart:convert';

import 'package:chat/casheManager/hive_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/init.dart';
import 'package:chat/models/contact_model.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/models/new_user_model.dart';
import 'package:chat/pages/setting/setting_get.dart';
import 'package:chat/services/base_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OfflineMessageService extends BaseService {
  final settingGet = SettingGet();
  final Uri url = Uri.parse(
    '${Config.httpsServicesBaseUrl}/get-latest-offline-message',
  );

  final Uri dropUrl = Uri.parse(
    '${Config.httpsServicesBaseUrl}/clear-latest-offline-message',
  );

  Future<void> call(Map<String, dynamic> args) async {
    final client = http.Client();
    try {
      print(url);
print(args);
print(Config.userModel?.token);
      print("1");
      final response = await client.post(
        url,
        headers: {
          'authorization': 'Bearer ${Config.userModel?.token}',
        },
        body: args,
      );
print("2 ${response.statusCode}");
print(response.body);
      if (response.statusCode == 401) {
        await _logout();
        return;
      }

      if (response.statusCode != 200) {
        throw Exception(response.body);
        
      }
  print("3");
      final decodedResponse = jsonDecode(response.body);
  print("4");
      for (final messageObject in decodedResponse['data']) {
        final userJson = messageObject['user'][0];
    print("5");
        final user = NewUserModel(
          id: userJson['_id'],
          fullname: userJson['fullname'],
          username: userJson['username'],
        );

        final message = Message(
          date: DateTime.parse(messageObject['dateTime']),
          message: messageObject['message'],
          user: user,
        );

        await HiveCasheManager().save(
          ContactModel(
            user: user,
            messages: [message],
          ),
        );
      }
  print("6");
      await _dropMessage(args['userId']);
        print("7");
    } catch (e) {
      print('OfflineMessageService Error: $e');
    } finally {
      client.close();
    }
  }

  Future<void> _dropMessage(String userId) async {
    print("DROP MESSAGE CALLED: $userId");
    final client = http.Client();

    try {
      final response = await client.post(
        dropUrl,
        headers: {
          'authorization': 'Bearer ${Config.userModel?.token}',
        },
        body: {
          'userId': userId,
        },
      );

      if (response.statusCode == 401) {
        await _logout();
        return;
      }

      if (response.statusCode != 200) {
        print(response.body);
      }
    } finally {
      client.close();
    }
  }

  Future<void> _logout() async {
    AppInit().socket?.disconnect();
    settingGet.logout(); ;
    Get.offAllNamed(PageRoutes.welcome);
  }
}