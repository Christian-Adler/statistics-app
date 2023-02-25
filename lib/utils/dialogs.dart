import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> simpleOkDialog(String text,
      BuildContext context,
      {
        String? title,
      }) async {
    return showDialog<void>(
      context: context,
      builder: (ctx) =>
          AlertDialog(
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

  /// show [SnackBar]
  /// * [content] Widget or Text
  static void showSnackBar(dynamic content, BuildContext context,
      {Duration? duration, SnackBarAction? snackBarAction}) {
    Duration d = duration ?? const Duration(seconds: 2);
    Widget c = (content is Widget)
        ? content
        : (content is String)
        ? Text(content)
        : const Text('invalid content given');
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: c,
        duration: d,
        action: snackBarAction,
      ),
    );
  }
}
