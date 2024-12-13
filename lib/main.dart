import 'package:flutter/material.dart';
import 'package:games_rr/screens/FavoriteScreen.dart';
import 'package:games_rr/screens/HomeScreen.dart';
import 'package:games_rr/screens/Sign_In.dart';
import 'package:games_rr/screens/Sign_Up.dart';
import 'package:games_rr/screens/profile_screen.dart';
import 'package:games_rr/screens/SearchScreen.dart';
import 'package:games_rr/widgets/CostumeBackGround.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:{
        '/':(context) => MainScreen(),
        '/SignInScreen' : (context) => SignInscreen(),
        '/SignUpScreen' : (context) => SignUpScreen(),
        '/Profile' : (context) => SearchScreen(),
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games-R-R',
      theme: ThemeData(scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home://ProfileScreen(),
       SignUpScreen(),
      //Homescreen()
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Todo: 1.Deklarasi variabel
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Homescreen(),
    const SearchScreen(),
    const Favoritescreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Todo: 2.body
      body:  CostumeGradient(child: _children[_currentIndex]),

      //todo: 3.BottomNavigatorBar
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: const Color(0xff1E3E62)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex=index;
              });
            },
            //Todo: 4.data child theme
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  label: "WishList"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: "Profile"),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: const Color(0xFF0b1640),
            showSelectedLabels: true,
          )),
    );
  }
}