import 'package:flutter/material.dart';

class Hoverimage extends StatefulWidget {

  final String games;

  const Hoverimage({super.key,  required this.games});

  @override
  State<Hoverimage> createState() => _HoverimageState();
}

class _HoverimageState extends State<Hoverimage> {
  bool isHovered =false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_){
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_){
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          width: isHovered ? 500:150,
          height: isHovered ? 300:300,
          child: Image.asset(widget.games,fit: BoxFit.cover,)
      ),
    );
  }
}

class SecondHover extends StatefulWidget {
  final String games; // Gambar yang akan ditampilkan

  const SecondHover({super.key, required this.games});

  @override
  _SecondHoverState createState() => _SecondHoverState();
}

class _SecondHoverState extends State<SecondHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.decelerate,
        width: isHovered ? 100 : 50,
        height: isHovered ? 200 : 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.black54 : Colors.transparent,
              blurRadius: 10,
              offset: Offset(0, 25),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            widget.games,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}