import 'package:flutter/material.dart';
import 'package:ttg/styles/text_styles.dart';

Widget teachingSubjectsTile(int index, String subjectName,Function? deleteFunction) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Flexible(
      child: Text(
        '$index. $subjectName',
        style: AppTextStyles.secondaryStyle.copyWith(fontSize: 18),
      ),
    ),
    IconButton(onPressed: () {
      if(deleteFunction != null){
        deleteFunction();
      }
    }, icon: const Icon(Icons.delete))
  ]);
}