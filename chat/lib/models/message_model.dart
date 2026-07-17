import 'package:chat/constants/config.dart';
import 'package:chat/models/new_user_model.dart';
import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 2)
class Message extends HiveObject {
  @HiveField(0)
  final NewUserModel user;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
   bool seen;

  Message({required this.date, required this.message, required this.user , this.seen = false});
  factory Message.fromJson(Map<String, dynamic> json) => Message(
    date: DateTime.now(),
    message: json['message'],
    user: NewUserModel.fromSocketJson(json['from']),
    seen:false
  );


    bool isMyMessage() {
    return Config.userModel!.id== user.id;
  }
}
