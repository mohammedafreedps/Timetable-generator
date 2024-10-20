import 'package:flutter/material.dart';

Future appDialogBox({required BuildContext context,required String title, Function? noFunction, required Function yesFunction}) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
              onPressed: () {
              if(noFunction != null){
              noFunction();
              }
              Navigator.of(context).pop();
            }, child: const Text('No')),
            TextButton(onPressed: () {
              yesFunction();
              Navigator.of(context).pop();
            }, child: const Text('Yes'))
          ],
        );
      });
}
