import 'package:flutter/material.dart';
import 'package:games_rr/data/games_data.dart';
import '../Widgets/HoverImage.dart';
import '../model/gamesrr_model_data.dart';
import 'layar_detail.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  //todo 8.Menambahkan method navigasi untuk mempermudah masuk kedalam DetailScreen dari ListView dan GridView
  void _navigateToDetailScreen(Games game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(games: game),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo 1.Membuat AppBar
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      //todo 2.Membuat singlechidlscrollview u
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            //todo 3. membuat bar yang akan menajadi judul untuk 4 game populer tahun ini
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff172F49)),
                  child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "Popular Games This Year",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white)),
                        WidgetSpan(
                            child: Icon(
                              Icons.local_fire_department,
                              color: Colors.deepOrange,
                            )),
                      ])),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //todo 4.menampilkan 4 game secara horizontal
            SizedBox(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: gameList.take(4).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: (){
                          _navigateToDetailScreen(gameList[index]); //Navigasi ke DetailScreeen
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hoverimage(games: gameList[index].imageAsset) //penerapan costume widget dalam menampilkan game
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 5,
            ),
            //todo 5.Membuat pembatas antar widget atas dan bawah
            const Divider(
              thickness: 2,
              color: Color(0xff172F49),
              endIndent: 100,
            ),
            const SizedBox(
              height: 5,
            ),
            //todo 6.Membuat bar judul untuk game rekomendasi
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff172F49)),
                  child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "Recommendation",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white)),
                        WidgetSpan(
                            child: Icon(
                              Icons.gamepad_outlined,
                              color: Colors.green,
                            )),
                      ])),
                ),
              ],
            ),
            //todo 7.Membuat gridview untuk menampilkan banyak game sekaligus
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: SizedBox(
                height: 700,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),//Mematikan fungsi scroll pada gridview dan hanya menggunakan SingleChildScrollView
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 6, //menampilkan 6 item dari gamelist
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                      onTap: (){
                        _navigateToDetailScreen(gameList.skip(4).take(6).toList()[index]);//navigasi dari item gridview ke DetailScreen
                      },
                        child: SecondHover(games: gameList.skip(4).take(6).toList()[index].imageAsset)
                        //(4) skip 4 item dan melanjutkan (6) item selanjutnya untuk ditampilkan
                      //Menggunakan Costume widget untuk menambahkan efek
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

