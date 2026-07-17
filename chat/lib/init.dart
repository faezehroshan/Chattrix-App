import 'package:chat/casheManager/hive_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/models/new_user_model.dart';
import 'package:chat/pages/chat/chat_get.dart';
import 'package:chat/pages/messages/messages_get.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();
  IO.Socket? socket;
  NewUserModel? currentChatUser;
  void initSocketClient() {
    AppInit().socket = IO.io(
      '${Config.socketServerBaseUrl}?token=${Config.userModel?.token}',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableForceNew()
          .build(),
    );

    AppInit().socket?.onConnect((data) => print('Connected to the server'));

    AppInit().socket?.onDisconnect(
      (data) => print('Disconnected from the server'),
    );

    AppInit().socket?.on("onMessage", (data) => _onMessegeHandler(data));

    AppInit().socket?.connect();
  }

  _onMessegeHandler(Map<String, dynamic> json) {
   final sender = NewUserModel.fromSocketJson(json['from']);

  final bool isCurrentChat =
      sender.id == currentChatUser?.id;

  final message = Message(
    date: DateTime.now(),
    message: json['message'],
    user: sender,
    seen: isCurrentChat,
  );

  if (isCurrentChat) {
    try {
      final chatGet = Get.find<ChatGet>();
      chatGet.messages.add(message);
      chatGet.onUpdateStream.sink.add(true);
    } catch (e) {}
  }

  HiveCasheManager().update(sender.id, message);

  Get.find<MessagesGet>()
      .contactSteam
      .sink
      .add(true);
  }
}
