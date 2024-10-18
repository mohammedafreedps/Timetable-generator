import 'package:flutter/material.dart';
import 'package:ttg/styles/app_styles.dart';

Widget coursesTile(Function deletefunction,Function editFunction, List<String> items,String courseTitle) {
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
            courseTitle,
            style: AppTextStyles.secondaryStyle.copyWith(fontSize: 25),
          ),
          const Divider(),
          Text(
            'Subjects:\n${items.asMap().entries.map((entry) => '${entry.key + 1}. ${entry.value}').join('\n')}',
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {
                deletefunction();
              }, icon: const Icon(Icons.delete)),
              IconButton(onPressed: () {
                editFunction();
              }, icon: const Icon(Icons.edit)),
            ],
          )
        ],
      ),
    ),
  );
}
