import 'package:chat/casheManager/hive_cashe_manager.dart';
import 'package:chat/casheManager/user_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/init.dart';
import 'package:chat/services/offline_message_service.dart';
import 'package:chat/services/token_fresher_service.dart';
import 'package:get/get.dart';

class SplashGet extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await UserCasheManager.isUserLoggedIn();

    if (!UserCasheManager.userLoginCheck) {
      Get.offAllNamed(PageRoutes.welcome);
      return;
    }

    Config.userModel = UserCasheManager.getUser();

    if (Config.userModel == null) {
      Get.offAllNamed(PageRoutes.welcome);
      return;
    }

    try {
      final service = TokenFresherService();

      await service.call({
        'userId': Config.userModel!.id,
        'username': Config.userModel!.username,
      });

      Config.userModel = UserCasheManager.getUser();

      if (Config.userModel == null || Config.userModel!.token.isEmpty) {
        Get.offAllNamed(PageRoutes.welcome);
        return;
      }

      AppInit().initSocketClient();

      await HiveCasheManager().init();

      final offlineMessageService = OfflineMessageService();

      await offlineMessageService.call({'userId': Config.userModel!.id});

      Get.offAllNamed(PageRoutes.messages);
    } catch (e) {
      await UserCasheManager.clear();

      Get.offAllNamed(PageRoutes.welcome);
    }
  }
}
