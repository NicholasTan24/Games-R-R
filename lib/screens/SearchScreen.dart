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
                    hintText: 'Cari Games ...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: _filteredGameList.length,
                itemBuilder: (context, index) {
                  Games game = _filteredGameList[index];
                  return ListTile(
                    title: Text(game.name),
                    subtitle: Text(game.requirements),
                    leading: Image.asset(
                      game.imageAsset,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DetailScreen(games: game);
                      }));
                    },
                  );
                },
              )),
        ],
      ),
    );
  }
}
