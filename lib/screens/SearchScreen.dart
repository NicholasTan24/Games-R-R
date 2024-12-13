import 'package:flutter/material.dart';
import 'package:games_rr/data/games_data.dart';
import 'package:games_rr/model/gamesrr_model_data.dart';
import 'package:games_rr/screens/layar_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //todo 1.deklarasi variabel
  List<Games> _filteredGames = gameList;
  String _seaarchQuer = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo 2.appbar pencarian game
      appBar: AppBar(
        title: const Text("Game Search"),
      ),
      //todo 3.body & column
      body: Column(
        children: [
          //todo 4.textfeild
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: const TextField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Cari Games",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF0b1640),
                    ),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          //todo 5.listview
          Expanded(
            child: ListView.builder(
                itemCount: _filteredGames.length,
                itemBuilder: (context, index) {
                  final Games = _filteredGames[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(games: gameList[index])));
                    },
                    child: Card(
                      color: Color(0xff1E3E62),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                Games.imageAsset,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Games.name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white,)),
                                const SizedBox(height: 4,),
                                Text(Games.genre,style: TextStyle(color: Colors.white,),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
