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
  final TextEditingController _searchController = TextEditingController();
  List<Games> _filteredGameList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterGameList);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.removeListener(_filterGameList);
    _searchController.dispose();
    super.dispose();
  }

  void _filterGameList() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredGameList = [];
      } else {
        _filteredGameList = gameList.where((games) {
          return games.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepPurple[50],
              ),
              child: TextField(
                controller: _searchController,
                autofocus: false,
                decoration: const InputDecoration(
                    hintText: 'Cari Games',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
              ),
            ),
          ),
          //todo 5.listview
          Expanded(
            child: ListView.builder(
                itemCount: _filteredGameList.length,
                itemBuilder: (context, index) {
                  final Games = _filteredGameList[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(games: Games)));//navigasi ke detailScreen
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
