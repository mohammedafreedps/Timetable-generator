import 'package:flutter/material.dart';
import 'package:ttg/styles/app_styles.dart';

Widget staffTile(){
  return Padding(
    padding: const EdgeInsets.only(bottom:  10),
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: AppColors.primaryColor),borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Staff Name',style: AppTextStyles.secondaryStyle.copyWith(fontSize: 25),),
          Text('Course Nmae BCA MBA',style: AppTextStyles.secondaryStyle.copyWith(fontSize: 15),),
          const Divider(),
          const Text('Subjects: \n English \n Physics \n Malayalam'),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.delete)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
            ],
          )
        ],
      ),
    ),
  );
}