import 'dart:convert';

import 'package:chat/casheManager/user_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/services/base_service.dart';
import 'package:http/http.dart' as http;

class RegisterService extends BaseService {
  final Uri url = Uri.parse("${Config.httpsServicesBaseUrl}/register");
  @override
  Future<bool> call(Map<String, dynamic> args) async {
    final client = http.Client();
    final response = await client.post(url, body: args);
    final decodeResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Config.errorHandler(
        title: decodeResponse['error_code'],
        error: decodeResponse['message'],
      );
    await  UserCasheManager.save(
        fullname: args['fullname'],
        username: args['username'],
        userId: decodeResponse['data']['insertedId'],
        token: decodeResponse['data']['token'],
      );
    await  Future.delayed(Duration(seconds: 1));
      return true;
    } else {
      Config.errorHandler(
        title: decodeResponse['error_code'],
        error: decodeResponse['message'],
      );
      return false;
    }
  }
}
