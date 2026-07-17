import 'package:chat/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class UserCasheManager {
  UserCasheManager._();

  static bool userLoginCheck = false;

  static const String USER_ID_KEY = '--user-id-key';
  static const String USER_NAME_KEY = '--user-name-key';
  static const String USER_FULLNAME_KEY = '--user-fullname-key';
  static const String USER_TOKEN_KEY = '--user-token-key';

  static UserModel? getUser() {
    final box = GetStorage();
    final userId = box.read(USER_ID_KEY);
    final username = box.read(USER_NAME_KEY);
    final fullname = box.read(USER_FULLNAME_KEY);
    final token = box.read(USER_TOKEN_KEY);

    if (userId != null && username != null && fullname != null && token != null) {
      return UserModel(
        id: userId,
        username: username,
        fullname: fullname,
        token: token,
      );
    }
    return null;
  }


  static Future<void> save({
    String? userId ,
    String? username ,
    String? fullname ,
    String? token,
  }) async {
    final box = GetStorage();
   if(userId != null) await box.write(USER_ID_KEY, userId);
    if(username != null) await box.write(USER_NAME_KEY, username);
    if(fullname != null) await box.write(USER_FULLNAME_KEY, fullname);
    if(token != null) await box.write(USER_TOKEN_KEY, token);
  }

  static Future<void> isUserLoggedIn() async {
    final box = GetStorage();
    final userId = await box.read(USER_ID_KEY);
    userLoginCheck = userId != null;
  }

  static Future<void> clear() async {
    final box = GetStorage();
    await box.erase();
  }
}
