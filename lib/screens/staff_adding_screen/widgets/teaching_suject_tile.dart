import 'package:flutter/material.dart';
import 'package:ttg/styles/text_styles.dart';

Widget teachingSubjectsTile() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
      '1. English',
      style: AppTextStyles.secondaryStyle.copyWith(fontSize: 18),
    ),
    IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
  ]);
}