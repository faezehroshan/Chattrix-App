import 'package:chat/casheManager/hive_cashe_manager.dart';
import 'package:chat/components/dialogs/addContact/add_contact_dialog.dart';
import 'package:chat/models/contact_model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class MessagesGet extends GetxController {
  List<ContactModel> contacts = [];
  PublishSubject<bool> contactSteam = PublishSubject<bool>();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void>  init() async {
    final list = await HiveCasheManager().getAll();
    contacts.clear();
    contacts.addAll(list);
    contactSteam.sink.add(true);
  }

  void addContact() {
    Get.dialog(AddContactDialog(), barrierDismissible: true);
  }



  var isSearchEnabled = false.obs;
}
