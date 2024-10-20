import 'package:flutter/material.dart';

Widget dashboardTile(String courseName,Function onPress){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(child: Text(courseName)),
      IconButton(onPressed: (){
        onPress();
      }, icon: const Icon(Icons.generating_tokens))
    ],
  );
}