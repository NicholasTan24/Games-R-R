import 'package:flutter/material.dart';
import 'package:games_rr/data/games_data.dart';
import 'package:games_rr/screens/HomeScreen.dart';
import 'package:games_rr/screens/layar_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games-R-R',
      theme: ThemeData(scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home:Gradient(child: Homescreen()),
    );
  }
}
class Gradient extends StatelessWidget {
  final Widget child;
  const Gradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xff1E3E62),Colors.white,],
              begin: Alignment.topCenter,
              end: Alignment(0,10)
          ),
        ),
        child: child,
      ),
    );
  }
}
