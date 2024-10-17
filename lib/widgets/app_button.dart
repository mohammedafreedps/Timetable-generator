import 'package:flutter/material.dart';
import 'package:ttg/styles/app_styles.dart';
import 'package:ttg/utils/constants.dart';


class AppButton extends StatelessWidget {
  double width;
  double height;
  String lable;
  Function? function;
  AppButton({required this.lable,this.width = 190,this.height = 50,this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(function!= null){
          function!();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: AppColors.primaryColor,borderRadius: BorderRadius.circular(BorderRadiouses.buttonRadious)),
        child: Center(
          child: Text(lable,style: AppTextStyles.primaryStyle,),
        ),
      ),
    );
  }
}