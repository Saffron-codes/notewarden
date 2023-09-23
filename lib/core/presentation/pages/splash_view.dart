import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.sizeOf(context).height / 4;
    return Center(
      child: Image.asset(
        "assets/app_icon.png",
        width: s,
        height: s,
      ),
    );
  }
}
