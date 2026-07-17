import 'package:chat/constants/colors.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/constants/text_style.dart';
import 'package:chat/pages/setting/setting_get.dart';
import 'package:chat/pages/setting/widget/setting_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  final settingGet = SettingGet();
  final avatarVersion = DateTime.now().millisecondsSinceEpoch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.secColor,
        title: Text("setting", style: MyTextStyles.appbar),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: MyColors.btnColor),
        ),
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 15),
              child: MaterialButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
                onPressed: settingGet.uploadAvatar,
                child: Obx(
                  () =>
                      (settingGet.profileAvatar.value == null &&
                          settingGet.profileAvatar.value!.path == '')
                      ? CircleAvatar(
                          backgroundColor: MyColors.secColor,
                          backgroundImage: FileImage(
                            settingGet.profileAvatar.value!,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: MyColors.backColor,
                          radius: 80,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                              imageUrl: Config.showAvatar(
                                Config.userModel!.id,
                                version: avatarVersion,
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                color: MyColors.chatColor,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),

            Text(
              Config.userModel?.fullname ?? "User",
              style: MyTextStyles.header,
            ),
            const SizedBox(height: 20),
            SettingItemWidget(
              title: "sign out",
              icon: Icons.exit_to_app_outlined,
              onTapped: settingGet.logout,
            ),
            SettingItemWidget(
              title: "change password",
              icon: CupertinoIcons.lock,
              onTapped: () {},
            ),
          ],
        ),
      ),
    );
  }
}
