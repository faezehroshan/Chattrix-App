
import 'package:chat/casheManager/user_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/services/login_service.dart';
import 'package:get/get.dart';

class LoginGet extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var loading = false.obs;

  void loginToAccount() async {
    if (username.value.isEmpty || password.value.isEmpty) {
      Config.errorHandler(
          title: 'Empty fields', error: 'Please enter all the fields!');
      return;
    }

    if (!loading.value) {
      loading.value = true;
      try {
        final service = LoginService();
        final result = await service
            .call({'username': username.value, 'password': password.value});
        loading.value = false;
        if (result) {
          Config.userModel = UserCasheManager.getUser();
          Get.offAllNamed(PageRoutes.splash);
        }
      } catch (er) {
        Config.errorHandler(title: 'Error', error: er.toString());
        loading.value = false;
      }
    }
  }
}