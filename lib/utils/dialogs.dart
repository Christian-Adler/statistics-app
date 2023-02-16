import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> simpleOkDialog(BuildContext context, String text, String? title) async {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: title == null ? null : Text(title),
        content: Text(
          text,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'))
        ],
      ),
    );
  }
}
