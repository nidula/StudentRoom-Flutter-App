import 'package:flutter/material.dart';

class CustomAlert {
  static Future<void> alertDialogBuilder({
    required BuildContext context,
    required String title,
    required String message,
    required String action,
  }) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: Text(action),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
