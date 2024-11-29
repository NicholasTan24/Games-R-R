import 'package:flutter/material.dart';

class Hoverimage extends StatefulWidget {

  final String displayList;
  const Hoverimage({super.key, required this.displayList});

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
        child: Image.asset(widget.displayList,fit: BoxFit.cover,)
      ),
    );
  }
}
