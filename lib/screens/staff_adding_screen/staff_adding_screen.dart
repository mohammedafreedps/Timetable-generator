import 'package:flutter/material.dart';
import 'package:ttg/screens/staff_adding_screen/widgets/teaching_suject_tile.dart';
import 'package:ttg/styles/app_styles.dart';
import 'package:ttg/utils/constants.dart';
import 'package:ttg/widgets/app_button.dart';
import 'package:ttg/widgets/app_dropdown_button.dart';
import 'package:ttg/widgets/app_textfield.dart';

class StaffAddingScreen extends StatelessWidget {
  StaffAddingScreen({super.key});

  final List<String> items = ['Course A', 'Course B', 'Course C', 'Course D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Staff Name',
              style: AppTextStyles.secondaryStyle.copyWith(fontSize: 20),
            ),
            appTextField(),
            const SizedBox(
              height: 20,
            ),
            appDropdownButton(items: items, hintText: 'Select Course'),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              appDropdownButton(items: items, hintText: 'Select Subjects'),
              AppButton(
                lable: 'Add',
                width: 100,
                height: 40,
              )
            ]),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(itemBuilder: (context,index){
                return teachingSubjectsTile();
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(lable: 'Save'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
