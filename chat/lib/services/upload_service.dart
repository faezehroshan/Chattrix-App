import 'dart:convert';
import 'package:chat/constants/config.dart';
import 'package:chat/services/base_service.dart';
import 'package:http/http.dart' as http;

class UploadService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/upload-avatar');
  Future<bool> call(Map<String, dynamic> args) async {
    final req = http.MultipartRequest('put', url)
      ..headers['Content-Type'] = 'multipart/form-data'
      ..headers['userId'] = args['userId']
      ..headers['Authorization'] = 'Bearer ${Config.userModel!.token}';

    req.files.add(await http.MultipartFile.fromPath('avatar', args['avatar']));
    final response = await http.Response.fromStream(await req.send());
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Config.errorHandler(
        title: decodedResponse['error_code'],
        error: decodedResponse['message'],
      );
      return true;
    } else {
      Config.errorHandler(
        title: decodedResponse['error_code'],
        error: decodedResponse['message'],
      );
      return false;
    }
  }
}
