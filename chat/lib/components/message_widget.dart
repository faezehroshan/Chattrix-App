
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/config.dart';
import 'package:chat/constants/text_style.dart';
import 'package:chat/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageWidget extends StatelessWidget {
  final ContactModel contact;
   final avatarVersion = DateTime.now().millisecondsSinceEpoch;
   MessageWidget({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int badgeCount = contact.messages
        .where((element) => element.seen == false)
        .toList()
        .length;

    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: () => Get.toNamed(PageRoutes.chat, arguments: contact.user),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: .5, color: Colors.grey.shade300)),
            ),
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: MyColors.secColor,
                    child:
                     ClipOval(
                       child: CachedNetworkImage(
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        imageUrl: Config.showAvatar(contact.user.id, version: avatarVersion),
                        errorWidget: (context, url, error) => Icon(Icons.person,
                            color: MyColors.chatColor, size: 35),
                                           ),
                     ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(contact.user.fullname,
                                style: MyTextStyles.title),
                          ),
                          Text(
                              contact.messages.isNotEmpty
                                  ? _beautifyDate(contact.messages.last.date)
                                  : '',
                              style: MyTextStyles.small)
                        ],
                      ),
                      SizedBox(
                        height: 16,
                        child: Text(
                            contact.messages.isNotEmpty
                                ? contact.messages.last.message
                                : '',
                            style: MyTextStyles.headline
                                .copyWith(overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (badgeCount > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: MyColors.secColor,
                child: Text(badgeCount.toString(),
                    style: MyTextStyles.small.copyWith(
                        color: MyColors.btnColor, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
      ],
    );
  }

  String _beautifyDate(DateTime date) {
    return "${date.month}/${date.day} ${date.hour}:${date.minute}";
  }
}