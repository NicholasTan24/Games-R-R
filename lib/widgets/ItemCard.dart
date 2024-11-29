import 'package:flutter/material.dart';
import 'package:games_rr/model/games.dart';

class Itemcard extends StatelessWidget {
  final Games games;

  const Itemcard({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff172F49),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(4),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //todo
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                games.imageAsset,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //todo
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              games.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),
            ),
          ),
          //todo
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              games.genre,
              style: const TextStyle(fontSize: 12,color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
