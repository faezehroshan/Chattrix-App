import 'dart:convert';

import 'package:chat/casheManager/user_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/services/base_service.dart';
import 'package:http/http.dart' as http;

class LoginService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/signin');
  Future<bool> call(Map<String, dynamic> args) async {
    final client = http.Client();
    final response = await client.post(url, body: args);
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          error: decodedResponse['message']);
      await UserCasheManager.save(
          fullname: decodedResponse['data']['fullname'],
          userId: decodedResponse['data']['_id'],
          username: decodedResponse['data']['username'],
          token: decodedResponse['data']['token']);
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } else {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          error: decodedResponse['message']);
      return false;
    }
  }
}