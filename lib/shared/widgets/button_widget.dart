import 'package:flutter/material.dart';

import '../constants/shared_constants_export.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      this.title,
      required this.onPressed,
      this.colorText,
      this.colorButton,
      this.height});

  final String? title;
  final Function onPressed;
  final Color? colorText;
  final Color? colorButton;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 48,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: colorButton ?? Color(0xff007DC0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color:
                colorButton != null ? Color(0xffE3E5E5) : Colors.transparent),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: () {
          onPressed();
        },
        child: title == null
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                title!,
                style: styleS16W5(colorText ?? Colors.white),
              ),
      ),
    );
  }
}
