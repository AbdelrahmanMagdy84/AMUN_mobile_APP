import 'package:flutter/material.dart';

class DialogManager {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please wait..."),
            content: Container(
                width: 50,
                height: 50,
                child: Center(child: CircularProgressIndicator())),
          );
        });
  }

  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
          );
        });
  }

  static void showGeneralDialog(
      BuildContext context, String title, String content) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
          );
        });
  }

  static void stopLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
