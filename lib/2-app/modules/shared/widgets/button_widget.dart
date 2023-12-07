import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prova_seventh/2-app/utils/colors.dart';

class ButtonWidget extends StatefulWidget {
  final FutureOr Function()? onPressed;
  final String text;
  const ButtonWidget(this.text, {super.key, this.onPressed});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (isLoading) return;
        setState(() {
          isLoading = true;
        });
        await widget.onPressed?.call();
        setState(() {
          isLoading = false;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: defaultBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, MediaQuery.of(context).size.height * 0.06),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: white)
            : Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 20,
                  color: white,
                ),
              ),
      ),
    );
  }
}
