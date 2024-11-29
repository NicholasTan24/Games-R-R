import 'package:flutter/material.dart';

import 'Screen/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

