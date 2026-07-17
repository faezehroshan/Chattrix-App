import 'dart:convert';
import 'package:chat/constants/config.dart';
import 'package:chat/models/new_user_model.dart';
import 'package:chat/services/base_service.dart';
import 'package:http/http.dart' as http;

class AddContactService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/new-contact');
  Future<NewUserModel?> call(Map<String, dynamic> args) async {
    final client = http.Client();
    final response = await client.post(url,
    headers: {'authorization': 'Bearer ${Config.userModel?.token}'},
     body: args);
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          error: decodedResponse['message']);
       return NewUserModel.fromJson(decodedResponse['data']);
    } else {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          error: decodedResponse['message']);
      return null;
    }
  }
}