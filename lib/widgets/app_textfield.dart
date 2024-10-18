import 'package:flutter/material.dart';
import 'package:ttg/styles/app_colors.dart';

Widget appTextField({TextEditingController? controller}) {
  return TextField(
    controller: controller,
    cursorColor: AppColors.primaryColor,
    decoration: InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor)),
    ),
  );
}
