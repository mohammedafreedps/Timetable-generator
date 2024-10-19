import 'package:flutter/material.dart';
import 'package:ttg/styles/app_styles.dart';

Widget staffTile(
    {Function? editFunction,
    Function? deleteFunction,
    required List<String> subjects,
    required String courseName,
    required String staffName}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            staffName,
            style: AppTextStyles.secondaryStyle.copyWith(fontSize: 25),
          ),
          Text(
            courseName,
            style: AppTextStyles.secondaryStyle.copyWith(fontSize: 15),
          ),
          const Divider(),
          Text(
            'Subjects:\n${subjects.asMap().entries.map((entry) => '${entry.key + 1}. ${entry.value}').join('\n')}',
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {
                if(deleteFunction != null){
                  deleteFunction();
                }
              }, icon: const Icon(Icons.delete)),
              IconButton(onPressed: () {
                if(editFunction != null){
                  editFunction();
                }
              }, icon: const Icon(Icons.edit)),
            ],
          )
        ],
      ),
    ),
  );
}
