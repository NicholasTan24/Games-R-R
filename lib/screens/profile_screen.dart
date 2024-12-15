import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO: 1.Deklarasikan variabel yang dibutuhkan
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  int wishListCount = 0;
  String password = '';
  String profilePicture ='GambarGame/placeholder.png';
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  // mengmabil data dari signUpScreen
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // mengambil key untuk melakukan dekripsi
    final String? keyBase64 = prefs.getString('key');
    final String? ivBase64 = prefs.getString('iv');


    if (keyBase64 != null && ivBase64 != null) {
      final key = encrypt.Key.fromBase64(keyBase64);
      final iv = encrypt.IV.fromBase64(ivBase64);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      // mengambil data yang dienkripsi
      final String? encryptedFullName = prefs.getString('fullname');
      final String? encryptedUserName = prefs.getString('username');
      final String? encryptedPassword = prefs.getString('password');

      if (encryptedFullName != null && encryptedUserName != null && encryptedPassword != null) {
        // melakukan deskripsi data
        final decryptedFullName = encrypter.decrypt64(encryptedFullName, iv: iv);
        final decryptedUserName = encrypter.decrypt64(encryptedUserName, iv: iv);
        final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);

        setState(() {
          fullName = decryptedFullName;
          userName = decryptedUserName;
          password = decryptedPassword;
        });
      }
    }
  }
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userName,'');
    await prefs.setString(password,'');
    await prefs.setString(password,'');
    setState(() {
      isSignedIn =false;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        profilePicture = pickedFile.path;
      });
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
                title: Text(
                  'Image Source',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.gallery); // Pilih dari galeri
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.camera); // Ambil gambar dengan kamera
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool? signedInStatus = ModalRoute.of(context)?.settings.arguments as bool?;
    isSignedIn = signedInStatus ?? false;//mengambil nilai true dari signInScreen

    if (isSignedIn) {
      _loadUserData(); // menjalankan proses data pengguna jika sudah login
    }

    void signIn() {
      Navigator.pushNamed(context, '/SignInScreen');
    }


    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.blueGrey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // ProfileHeader
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100 - 10),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                            AssetImage(profilePicture),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: () {
                              _showPicker();
                            },
                            icon: const Icon(Icons.camera_alt, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Divider(color: Colors.black),
                const SizedBox(height: 4),

                // Profile Info - Pengguna
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.person_search, color: Colors.lime),
                          SizedBox(width: 8),
                          Text('Pengguna', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(': $userName', style: const TextStyle(fontSize: 18)),
                    ),
                    if (isSignedIn) const Icon(Icons.edit),
                  ],
                ),

                const SizedBox(height: 4),
                const Divider(color: Colors.black),
                const SizedBox(height: 4),

                // Profile Info - Nama
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.person, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Nama', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(': $fullName', style: const TextStyle(fontSize: 18)),
                    ),
                    if (isSignedIn) const Icon(Icons.edit),
                  ],
                ),

                const SizedBox(height: 4),
                const Divider(color: Colors.black),
                const SizedBox(height: 4),

                // Profile Info - Password
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.lock, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text( (': ' + '*' * password.length), style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                const Divider(color: Colors.black),
                const SizedBox(height: 4),

                // Profile Info - Favorit
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 8),
                          Text('WishList', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(': $wishListCount', style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                ),

                const SizedBox(height: 4),
                const Divider(color: Colors.black),
                const SizedBox(height: 20),

                // Profile Actions
                isSignedIn
                    ? TextButton(onPressed: signOut, child: const Text('Sign Out',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
                    : TextButton(
                  onPressed: signIn,
                  child: const Text('Sign In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}