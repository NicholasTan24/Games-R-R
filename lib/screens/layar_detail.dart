import 'package:flutter/material.dart';
import 'package:games_rr/widgets/CostumeBackGround.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/gamesrr_model_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  final Games games;

  const DetailScreen({super.key, required this.games});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  bool isFavorite = false;
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
    _loadFavoriteStatus();
  }
  // Memeriksa status sign in
  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('isSignedIn') ?? false;
    setState(() {
      isSignedIn = signedIn;
    });
  }
  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool favorite = prefs.getBool('favorite_${widget.games.name}') ?? false;
    setState(() {
      isFavorite = favorite;
    });
  }
  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Memeriksa apakah pengguna sudah sign in
    if(!isSignedIn) {
      // Jika belum sign in, arahkan ke SignInScreen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/SignInScreen');
      });
      return;
    }
    bool favoriteStatus = !isFavorite;
    prefs.setBool('favorite_${widget.games.name}',favoriteStatus);
  }

  @override
  Widget build(BuildContext context) {
    return CostumeGradient(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //tampilan besarnya
              Stack(
                //padding gambar
                children: [
                  //padding image
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        widget.games.imageAsset,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //padding back button
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.brown[200],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          )),
                    ),
                  )
                ],
              ),
      
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // info atas(nama game dan tombol favorit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.games.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              _toggleFavorite();
                            },
                            icon: Icon(Icons.star_border))
                      ],
                    ),
                    //gambar gambarnya
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(color: Colors.black, thickness: 2),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.games.preview.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  // bingkai
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.indigo.shade700,
                                            width: 2,
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.games.preview[index],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 150,
                                            height: 150,
                                            color: Colors.indigo.shade700,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Tap untuk memperbesar',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          // info tengah (realese date, genre, requirements. dan deskripsi)
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month, color: Colors.black),
                              const SizedBox(width: 20),
                              const SizedBox(
                                  width: 100,
                                  child: Text('Release Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Text(': ${widget.games.releaseDate}'),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Icon(Icons.theater_comedy, color: Colors.black),
                              const SizedBox(width: 20),
                              const SizedBox(
                                  width: 100,
                                  child: Text('Genre',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Text(': ${widget.games.genre}'),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 20),
                              const SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Icon(Icons.monitor, color: Colors.black),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text('Requirements   :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                              Text(widget.games.requirements,
                                  textAlign: TextAlign.justify),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 20),
                              const SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Icon(Icons.gamepad_rounded,
                                        color: Colors.black),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text('Game Description   :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                              Text(widget.games.description,
                                  textAlign: TextAlign.justify),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
