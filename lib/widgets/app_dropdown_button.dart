import 'package:flutter/material.dart';
import 'package:ttg/styles/styles.dart';


Widget appDropdownButton(
    {required List<String> items,
    required String hintText,
    Function(String?)? onChange}) {
  return DropdownButton(
      hint: Text(
        hintText,
        style: AppTextStyles.secondaryStyle,
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        if (onChange != null) {
          onChange(value);
        }
      });
}
