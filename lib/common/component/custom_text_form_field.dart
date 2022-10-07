import 'package:eunbinlib_app/common/const/colors.dart';
import 'package:eunbinlib_app/common/const/data.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool multiline;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.multiline = false,
    this.maxLines = 1,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: multiline ? TextInputType.multiline : TextInputType.text,
      maxLines: maxLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
      ),
    );
  }
}
