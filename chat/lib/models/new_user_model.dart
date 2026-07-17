
import 'package:hive/hive.dart';

part 'new_user_model.g.dart';

@HiveType(typeId: 1)
class NewUserModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String fullname;
  @HiveField(2)
  final String username;
  NewUserModel({required this.id,
   required this.fullname,
    required this.username});

NewUserModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        fullname = json['fullname'],
        username = json['username'];

 factory NewUserModel.fromSocketJson(Map<String, dynamic> json) => NewUserModel(
         id: json['userId'],
      fullname: json['fullname'],
      username: json['username']); 

}

