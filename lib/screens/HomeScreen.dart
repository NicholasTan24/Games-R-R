import 'package:flutter/material.dart';
import 'package:games_rr/data/games_data.dart';
import '../Widgets/HoverImage.dart';



class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
            SizedBox(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: gameList.take(4).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hoverimage(games: gameList[index].imageAsset)),
                    );
                  }),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 2,
              color: Color(0xff172F49),
              endIndent: 100,
            ),
            const SizedBox(
              height: 5,
            ),
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 700,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return  SecondHover(games: gameList.skip(4).take(6).toList()[index].imageAsset);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

