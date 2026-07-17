import 'package:chat/casheManager/hive_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/models/contact_model.dart';
import 'package:chat/pages/messages/messages_get.dart';
import 'package:chat/services/add_contact_service.dart';
import 'package:get/get.dart';

class AddContactGet extends GetxController {
  var username = ''.obs;
  var loading = false.obs;

  void add() async {
    if (username.value.isEmpty) {
      Config.errorHandler(
        title: 'Empty fields',
        error: 'Please enter the username!',
      );
      return;
    }

    if (!loading.value) {
      loading.value = true;
      try {
        final service = AddContactService();
        final result = await service.call({'username': username.value});
        loading.value = false;

        if (result != null) {
          final messagesGet = Get.find<MessagesGet>();

          HiveCasheManager().save(ContactModel(user: result, messages: []));
          messagesGet.init();
          Get.back();
          Get.offNamed(PageRoutes.chat, arguments: result);
        }
      } catch (e, s) {
        loading.value = false;
        Config.errorHandler(title: 'Error', error: e.toString());
        print(e);
        print(s);
      }
    }
  }
}
