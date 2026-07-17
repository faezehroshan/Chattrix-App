import 'dart:io';
import 'package:chat/casheManager/hive_cashe_manager.dart';
import 'package:chat/services/upload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat/casheManager/user_cashe_manager.dart';
import 'package:chat/constants/config.dart';
import 'package:get/get.dart';


class SettingGet extends GetxController {
  Rx<File?> profileAvatar = File('').obs;
  void uploadAvatar() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (pickedImage != null) {
      final uploadService = UploadService();
     final uploadResult = await uploadService.call({
      'userId':Config.userModel!.id,
      'avatar':pickedImage.path
     });
     if(uploadResult){
      profileAvatar.value = File(pickedImage.path);
     }
    
    }
  }

  void logout() async {
    await HiveCasheManager().clearAll();
  await UserCasheManager.clear();

  Config.userModel = null;

  Get.offAllNamed(PageRoutes.splash);
  }
}
