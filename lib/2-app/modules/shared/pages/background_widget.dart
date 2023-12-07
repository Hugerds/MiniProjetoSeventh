import 'package:flutter/material.dart';
import 'package:prova_seventh/2-app/utils/colors.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transparent,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(child: ColoredBox(color: background, child: child)),
      ),
    );
  }
}
