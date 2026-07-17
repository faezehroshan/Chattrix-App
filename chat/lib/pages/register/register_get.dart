import 'package:chat/casheManager/user_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/services/register_service.dart';
import 'package:get/get.dart';

class RegisterGet extends GetxController {
  var fullname = ''.obs;
  var username = ''.obs;
  var password = ''.obs;

  var loading = false.obs;

  void createNewAccount() async {
    if (fullname.value.isEmpty ||
        username.value.isEmpty ||
        password.value.isEmpty) {
      Config.errorHandler(
        title: "Empty field",
        error: "please enter all the fields",
      );
    }

    if (!loading.value) {
      loading.value = true;

      try {
        final service = RegisterService();
      final result = await service.call({
          'fullname': fullname.value,
          'username': username.value,
          'password': password.value,
        });
        loading.value = false;
        if (result) {
          Config.userModel = UserCasheManager.getUser();
          Get.offAllNamed(PageRoutes.splash);
        }
     
      } catch (err) {
        Config.errorHandler(title: "Error", error: err.toString());
      }
    }
  }
}
