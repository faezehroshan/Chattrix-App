import 'dart:convert';

import 'package:chat/casheManager/user_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/services/base_service.dart';
import 'package:http/http.dart' as http;

class TokenFresherService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/refresh-token');

  Future<void> call(Map<String, dynamic> args) async {
    final client = http.Client();

    try {
      final response = await client.post(
        url,
        headers: {
          'authorization': 'Bearer ${Config.userModel?.token}',
        },
        body: args,
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await UserCasheManager.save(
          token: decodedResponse['data']['token'],
        );
      } else {
        Config.errorHandler(
          title: decodedResponse['error_code'],
          error: decodedResponse['message'],
        );
      }
    } finally {
      client.close();
    }
  }
}