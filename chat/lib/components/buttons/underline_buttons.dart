
import 'package:chat/constants/colors.dart';
import 'package:chat/constants/text_style.dart';
import 'package:flutter/material.dart';

class UnderlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const UnderlineButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text(title,
          style: MyTextStyles.button.copyWith(
              color: MyColors.btnColor,)),
    );
  }
}