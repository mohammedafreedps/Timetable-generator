import 'package:flutter/material.dart';
import 'package:ttg/styles/app_styles.dart';

Widget addedSubjectsTile(Function function, int index, String title) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Flexible(
      child: Text(
        '${index.toString()}. $title',
        style: AppTextStyles.secondaryStyle.copyWith(fontSize: 18),
      ),
    ),
    IconButton(
        onPressed: () {
          function();
        },
        icon: const Icon(Icons.delete))
  ]);
}
