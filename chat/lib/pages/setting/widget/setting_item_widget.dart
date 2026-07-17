import 'package:chat/constants/colors.dart';
import 'package:chat/constants/text_style.dart';
import 'package:flutter/material.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTapped;
  const SettingItemWidget({super.key, required this.title,  this.icon, this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      width: double.infinity,
      child: InkWell(
        onTap: onTapped,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10,  top: 15, bottom: 15),
              child: Icon(icon, size: 30, color: MyColors.secColor),
            ),

            SizedBox(width: 10),
            _title,
          ],
        ),
      ),
    );
  }

  Widget get _title => Text(title, style: MyTextStyles.title);
}
