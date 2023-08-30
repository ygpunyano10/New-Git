import 'package:flutter/material.dart';

class MyDialog {
  void myDialogPrimary(BuildContext context,
      {required String title,
      required String content,
      String? buttonText,
      required void Function()? onPressed}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                onPressed: onPressed,
                child: Text(buttonText ?? 'Ok'),
              ),
            ],
          );
        });
  }

  void myAlertDialog(BuildContext context, {required String content}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(content),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
