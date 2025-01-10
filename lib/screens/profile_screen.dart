import 'dart:io';
import 'package:flutter/material.dart';
import 'package:games_rr/Widgets/GameBackGround.dart';
import 'package:games_rr/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = false;
  String fullName = '';
  String userName = '';
  String password = '';
  String email = '';
  String profilePicture = 'GambarGame/placeholder.png';
  final picker = ImagePicker();

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? keyBase64 = prefs.getString('key');
    final String? ivBase64 = prefs.getString('iv');

    if (keyBase64 != null && ivBase64 != null) {
      final key = encrypt.Key.fromBase64(keyBase64);
      final iv = encrypt.IV.fromBase64(ivBase64);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final String? encryptedFullName = prefs.getString('fullname');
      final String? encryptedUserName = prefs.getString('username');
      final String? encryptedPassword = prefs.getString('password');
      final String? encryptedEmail = prefs.getString('email');

      // Jika data terdeteksi, lakukan dekripsi dan set state
      setState(() {
        fullName = encryptedFullName != null ? encrypter.decrypt64(encryptedFullName, iv: iv) : '';
        userName = encryptedUserName != null ? encrypter.decrypt64(encryptedUserName, iv: iv) : '';
        password = encryptedPassword != null ? encrypter.decrypt64(encryptedPassword, iv: iv) : '';
        email = encryptedEmail != null ? encrypter.decrypt64(encryptedEmail, iv: iv) : '';
      });
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);
    setState(() {
      isSignedIn = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  Future<void> signIn() async {
    await Navigator.pushNamed(context, '/SignInScreen');
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
                'Select Image Source',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera, color: Colors.black, size: 28),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.camera);
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
    final isSignedIn = signedInStatus ?? false;
    if (isSignedIn) {
      _loadUserData();
    }

    return Scaffold(
      body: Stack(
        children: [
          CostumeContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 120),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: profilePicture == 'GambarGame/placeholder.png'
                            ? const AssetImage('GambarGame/placeholder.png')
                            : FileImage(File(profilePicture)) as ImageProvider,
                      ),
                    ),
                    if (isSignedIn)
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.black, size: 28),
                        onPressed: _showPicker,
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.person, 'Username', userName, isSignedIn),
                        _buildInfoRow(Icons.person_outline, 'Full Name', fullName, isSignedIn),
                        _buildInfoRow(Icons.lock, 'Password', '*' * password.length, isSignedIn),
                        _buildInfoRow(Icons.email, 'Email', email, isSignedIn),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isSignedIn
                    ? ElevatedButton(
                  onPressed: signOut,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Sign Out', style: TextStyle(fontSize: 18)),
                )
                    : ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Sign In', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isSignedIn) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
          if (isSignedIn && label != 'Wish List')
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF0b1640)),
              onPressed: () {
                _showEditDialog(label);
              },
            ),
        ],
      ),
    );
  }

  void _showEditDialog(String label) {
    final controller = TextEditingController();
    if (label == 'Username') controller.text = userName;
    if (label == 'Full Name') controller.text = fullName;
    if (label == 'Password') controller.text = password;
    if (label == 'Email') controller.text = email;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: controller,
            obscureText: label == 'Password',
            decoration: InputDecoration(hintText: 'Masukkan $label baru'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  if (label == 'Username') {
                    userName = controller.text;
                  }
                  if (label == 'Full Name') {
                    fullName = controller.text;
                  }
                  if (label == 'Password') {
                    password = controller.text;
                  }
                  if (label == 'Email') {
                    email = controller.text;
                  }
                });

                // Simpan perubahan ke SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                final keyBase64 = prefs.getString('key');
                final ivBase64 = prefs.getString('iv');
                if (keyBase64 != null && ivBase64 != null) {
                  final key = encrypt.Key.fromBase64(keyBase64);
                  final iv = encrypt.IV.fromBase64(ivBase64);
                  final encrypter = encrypt.Encrypter(encrypt.AES(key));

                  if (label == 'Username') {
                    prefs.setString('username', encrypter.encrypt(controller.text, iv: iv).base64);
                  }
                  if (label == 'Full Name') {
                    prefs.setString('fullname', encrypter.encrypt(controller.text, iv: iv).base64);
                  }
                  if (label == 'Password') {
                    prefs.setString('password', encrypter.encrypt(controller.text, iv: iv).base64);
                  }
                  if (label == 'Email') {
                    prefs.setString('email', encrypter.encrypt(controller.text, iv: iv).base64);
                  }
                }

                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
