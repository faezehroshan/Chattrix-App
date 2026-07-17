
import 'package:chat/models/new_user_model.dart';


class UserModel  {

  final String id;
  final String fullname;
  final String username;
  final String token;

  UserModel({ required this.id,required this.fullname,required this.username, required this.token});


NewUserModel toNewUserModel() {
    return NewUserModel(
      id: id,
      fullname: fullname,
      username: username,
    );
  }


}