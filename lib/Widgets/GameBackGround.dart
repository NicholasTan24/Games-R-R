import 'dart:ui';
import 'package:flutter/material.dart';

class CostumeBackground extends StatefulWidget {
  final Widget child;

  CostumeBackground({Key? key, required this.child}) : super(key: key);

  @override
  _CostumeBackgroundState createState() => _CostumeBackgroundState();
}

class _CostumeBackgroundState extends State<CostumeBackground> {
  int _backgroundImageIndex = 0; // Index untuk background image
  List<String> _backgroundImages = [
    'GambarGame/blur1.png',
    'GambarGame/blur2.png',
    'GambarGame/blur3.png',
    'GambarGame/blur4.png',
  ];

  @override
  void initState() {
    super.initState();
    // menganti gambar 3 detik sekali
    _startBackgroundImageTransition();
  }

  void _startBackgroundImageTransition() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _backgroundImageIndex = (_backgroundImageIndex + 1) % _backgroundImages.length;
      });
      _startBackgroundImageTransition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // membuat blur gambar
        Positioned.fill(
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Image.asset(
                  _backgroundImages[_backgroundImageIndex],
                  key: ValueKey<int>(_backgroundImageIndex),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),

              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ],
          ),
        ),
        widget.child,
      ],
    );
  }
}


// membuat contume container dengan metode yang sama
class CostumeContainer extends StatefulWidget {
  const CostumeContainer({Key? key}) : super(key: key);

  @override
  _CostumeContainerState createState() => _CostumeContainerState();
}

class _CostumeContainerState extends State<CostumeContainer> {
  int _backgroundImageIndex = 0; // Index untuk background image
  final List<String> _backgroundImages = [
    'GambarGame/judul1.jpeg',
    'GambarGame/judul7.png',
    'GambarGame/judul10.jpg',
    'GambarGame/judul5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startBackgroundImageTransition();
  }

  void _startBackgroundImageTransition() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _backgroundImageIndex = (_backgroundImageIndex + 1) % _backgroundImages.length;
      });
      _startBackgroundImageTransition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: Container(
        key: ValueKey<int>(_backgroundImageIndex),
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(_backgroundImages[_backgroundImageIndex]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


