import 'package:flutter/material.dart';
import 'package:games_rr/data/games_data.dart';
import '../widgets/HoverImage.dart';
import '../widgets/ItemCard.dart';

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
        title: Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff172F49)),
                  child: RichText(
                      text: TextSpan(children: [
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hoverimage(displayList: displayList[index])),
                    );
                  }),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 2,
              color: Color(0xff172F49),
              endIndent: 100,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff172F49)),
                  child: RichText(
                      text: TextSpan(children: [
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 1020,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: gameList.length,
                itemBuilder: (context, index) {
                  return Itemcard(games: gameList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
