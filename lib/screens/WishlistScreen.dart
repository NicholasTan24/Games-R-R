import 'package:flutter/material.dart';
import 'package:games_rr/data/games_data.dart';
import 'package:games_rr/screens/layar_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/gamesrr_model_data.dart';

class Wishlistscreen extends StatefulWidget {
  const Wishlistscreen({super.key});

  @override
  State<Wishlistscreen> createState() => _WishlistscreenState();
}

class _WishlistscreenState extends State<Wishlistscreen> {
  bool isSignedIn = false;
  List<Games> wishlistGames = []; // Daftar nama game di wishlist user

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('isSignedIn') ??
        false; // Mengambil nilai true apakah sudah signIn atau belum
    setState(() {
      isSignedIn = signedIn;
    });
    if (signedIn) {
      _loadWishlistItems(); // Jika signIn true maka akan mengeksekusi method loadWishList
    }
  }

  // Memuat wishlist games yang disimpan di SharedPreferences jika signIn true
  void _loadWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedGames = prefs.getStringList('wishlist') ?? [];
    setState(() {
      wishlistGames = gameList
          .where(
            (Games) => savedGames.contains(Games.name),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist Screen"),
      ),
      body: isSignedIn
          ? (wishlistGames.isEmpty
              ? Column(
                  children: [
                    Center(
                      child: Container(
                        color: const Color(0xFF0b1640),
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        margin: const EdgeInsets.symmetric(vertical: 250),
                        child: const Center(
                          child: Text(
                            "WishList Kamu Masih Kosong",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20,bottom: 7,top: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff172F49),
                          ),
                          child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                text: "Your WishList",
                                // Menampilkan berapa jumlah yang telah di wishlist
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff172F49),
                              ),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "${wishlistGames.length}",
                                      // Menampilkan berapa jumlah yang telah di wishlist
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      children: const <InlineSpan>[
                                        WidgetSpan(
                                            child: SizedBox(
                                          width: 5,
                                        ))
                                        // memberikan spasi antara text dan icon
                                      ]),
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 500,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: wishlistGames.length,
                        itemBuilder: (context, index) {
                          Games games = wishlistGames[
                              index]; // Memastikan Setiap index yang telah masuk ke WishList sesuai dengan index Games
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          games:
                                              games))); // Navigasi ke DetailScreen sesuai dengan value index yang telah di inisialisasi
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                games.imageAsset, // Gambar game
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ))
          : Center(
              child: Container(
                color: const Color(0xFF0b1640),
                padding: const EdgeInsets.symmetric(horizontal: 100),
                margin: const EdgeInsets.symmetric(vertical: 250),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Silahkan Sign In Terlebih Dahulu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/SignInScreen');
                      },
                      child: const Text("Klik Di Sini",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize:
                                  20)), // Hanya akan tampil jika user belum sign in
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
