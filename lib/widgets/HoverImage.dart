import 'package:flutter/material.dart';

class Hoverimage extends StatefulWidget {
  final String games;
  const Hoverimage({super.key,  required this.games});

  @override
  State<Hoverimage> createState() => _HoverimageState();
}

class _HoverimageState extends State<Hoverimage> {
  // todo 1.inisialiasi variabel
  bool isHovered =false;

  @override
  Widget build(BuildContext context) {
    //todo 2.membuat fungsi region mouse untuk Listview
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
      },//membuat cursor mouse yang berada di atas gambar akan memberikan animasi
      child: AnimatedContainer(duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          width: isHovered ? 500:150,
          height: isHovered ? 300:300,//transformasi besarnya gambar jika true
          child: Image.asset(widget.games,fit: BoxFit.cover,)
      ),
    );
  }
}

//todo 3.Membuat fungsi region mouse yang sama untuk Gridview
class SecondHover extends StatefulWidget {
  final String games; // Gambar yang akan ditampilkan

  const SecondHover({super.key, required this.games});

  @override
  _SecondHoverState createState() => _SecondHoverState();
}

class _SecondHoverState extends State<SecondHover> {
  //todo 4. inisialisasi variabel
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
      child: AnimatedContainer( //memngunkan AnimatedContainer untuk mengekseskusi animasi
        duration: const Duration(seconds: 1),
        curve: Curves.decelerate,
        width: isHovered ? 100 : 50,
        height: isHovered ? 200 : 50,//tranformasi besarnya gambar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),//memberikan efek sudut tumnpul
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.black54 : Colors.transparent,
              blurRadius: 10,
              offset: Offset(0, 25),//mmeberikan efek bayangan jika ishovered true
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