import 'package:chat/casheManager/hive_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/init.dart';
import 'package:chat/models/contact_model.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/models/new_user_model.dart';
import 'package:chat/pages/messages/messages_get.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' hide Rx;

class ChatGet extends GetxController {
  NewUserModel? user;
  ContactModel? contact;
  var message = ''.obs;
  Rx<ContactModel?> contactRx = Rx<ContactModel?>(null);
  List<Message> messages = [];
  final onUpdateStream = PublishSubject<bool>();
  AppInit appInit = AppInit();
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  onInit() {
    user = Get.arguments;
    appInit.currentChatUser = user;

    onUpdateStream.listen((_) {
      Future.delayed(Duration(milliseconds: 100)).then(
        (_) =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent),
      );
    });

    initContact();
    super.onInit();
  }

  @override
  void dispose() {
    appInit.currentChatUser = null;
    super.dispose();
  }

  void userInfo() {}

  void initContact() async {
   contact = await HiveCasheManager().get(user!.id);
     contactRx.value = contact;
    await HiveCasheManager().updateLastSeen(user!.id);
    (Get.find<MessagesGet>()).contactSteam.sink.add(true);
    messages.clear();
    messages.addAll(contact?.messages ?? []);
    onUpdateStream.sink.add(true);

    Future.delayed(Duration(milliseconds: 100)).then(
      (_) => scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );
  }

  void send() {


    AppInit().socket?.emit('send-message', {
      'message': message.value,
      'to': user?.id ?? '',
    });

 
    final msg = Message(
      date: DateTime.now(),
      message: message.value,
      user: Config.userModel!.toNewUserModel(),
      seen: true,
    );
    messages.add(msg);
    HiveCasheManager().update(user!.id, msg);
    final messagesGet = Get.find<MessagesGet>();
    messagesGet.contactSteam.sink.add(true);
    message.value = '';
    controller.clear();
    onUpdateStream.sink.add(true);
  }
}
