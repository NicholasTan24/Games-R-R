import 'package:flutter/material.dart';

class CostumeGradient extends StatelessWidget {
  final Widget child;
  const CostumeGradient({super.key, required this.child});

  @override
  //todo 1.membuat wodget costume untuk backgroud semua screen
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0b1640),Colors.white,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}