import 'package:box_alarm/shared/constants/app_styles.dart';
import 'package:flutter/material.dart';

class RadioCheckboxWidget extends StatelessWidget {
  const RadioCheckboxWidget({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  });

  final String title;
  final bool isChecked;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          activeColor: const Color(0xff007DC0),
          checkColor: Colors.white,
          onChanged: onChanged,
        ),
        Text(
          title,
          style: styleS14W4(Color(0xff3E3E3E)),
        )
      ],
    );
  }
}
