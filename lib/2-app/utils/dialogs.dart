import 'package:flutter/material.dart';

Future<void> defaultDialog(
  BuildContext context, {
  required String title,
  required String content,
  void Function()? onPressed,
  String textButton = "Ok",
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            onPressed?.call();
            Navigator.of(context).pop();
          },
          child: Text(textButton),
        ),
      ],
    ),
  );
}
