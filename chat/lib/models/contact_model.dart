import 'package:chat/models/message_model.dart';
import 'package:chat/models/new_user_model.dart';
import 'package:hive/hive.dart';
part 'contact_model.g.dart';

@HiveType(typeId: 3)
class ContactModel extends HiveObject {
  @HiveField(0)
  final NewUserModel user;
  @HiveField(1)
  List<Message> messages = [];

  ContactModel({required this.user, this.messages = const []});
}
