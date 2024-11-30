import 'package:flutter/material.dart';
import '../model/gamesrr_model_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  final Games games;
  const DetailScreen({super.key, required this.games});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors:[
                  Color(0xFF0b1640),
                  Colors.white,
                ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //tampilan besarnya
                Stack(
                  //padding gambar
                  children: [
                    //padding image
                    Padding(
                      padding: EdgeInsets.all(8),
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      // info atas(nama game dan tombol favorit)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.games.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.favorite_border))
                        ],
                      ),
                      //gambar gambarnya
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: Colors.black,thickness: 2),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.games.previewUrls.length,
                                itemBuilder: (context, index){
                                  return Padding(padding: EdgeInsets.only(right:8),
                                    // bingkai
                                    child: GestureDetector(
                                      onTap: (){},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.indigo.shade700,
                                              width: 2,
                                            )
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.games.previewUrls[index],
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            placeholder: (context,url) => Container(
                                              width: 150,
                                              height: 150,
                                              color: Colors.indigo.shade700,
                                            ),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('Tap untuk memperbesar',style: TextStyle(
                              fontSize: 12, color: Colors.black54,
                            ),),
                            // info tengah (realese date, genre, requirements. dan deskripsi)
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(Icons.calendar_month, color: Colors.black),
                                SizedBox(width: 20),
                                SizedBox(width: 100,
                                    child: Text('Release Date', style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                                Text(': ${widget.games.releaseDate}'),
                              ],),
                            SizedBox(height: 15),
                            Row(children: [
                              Icon(Icons.theater_comedy, color: Colors.black),
                              SizedBox(width:20),
                              SizedBox(width:100,
                                  child: Text('Genre', style: TextStyle(
                                      fontWeight: FontWeight.bold))),
                              Text(': ${widget.games.genre}'),
                            ],),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              SizedBox(width:20),
                              SizedBox(width:200,
                                child: Row(
                                  children: [
                                    Icon(Icons.monitor, color: Colors.black),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text('Requirements   :', style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                  ),
                               Text('${widget.games.requirements}', textAlign: TextAlign.justify),
                            ],),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width:20),
                                SizedBox(width:200,
                                  child: Row(
                                    children: [
                                      Icon(Icons.gamepad_rounded, color: Colors.black),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Text('Game Description   :', style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                                Text('${widget.games.description}', textAlign: TextAlign.justify),
                              ],),
                            SizedBox(height: 30),
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
