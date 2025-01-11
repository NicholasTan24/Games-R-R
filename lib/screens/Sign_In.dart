import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:games_rr/Widgets/GameBackGround.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignInscreen extends StatefulWidget {
  SignInscreen({super.key});

  @override
  State<SignInscreen> createState() => _SignInscreenState();
}

class _SignInscreenState extends State<SignInscreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs(
      SharedPreferences prefs) async {
    final encryptedUsername = prefs.getString('username') ?? ' ';
    final encryptedPassword = prefs.getString('password') ?? ' ';
    final keyString = prefs.getString('key') ?? ' ';
    final ivString = prefs.getString('iv') ?? ' ';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);

    return {'username': decryptedUsername, 'password': decryptedPassword};
  }

  void _signIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (username.isNotEmpty && password.isNotEmpty) {
        final data = await _retrieveAndDecryptDataFromPrefs(prefs);
        if (data.isNotEmpty) {
          final decryptedUsername = data['username'];
          final decryptedPassword = data['password'];

          if (username == decryptedUsername && password == decryptedPassword) {
            _errorText = '';
            _isSignedIn = true;
            prefs.setBool('isSignedIn', true);
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacementNamed(context, '/', arguments: true);
          } else {
            setState(() {
              _errorText = 'Username atau password salah.';
            });
          }
        } else {
          setState(() {
            _errorText = 'Tidak ada data tersimpan.';
          });
        }
      } else {
        setState(() {
          _errorText = 'Username dan password tidak boleh kosong.';
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CostumeBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Nama Pengguna",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // Circular 10
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Kata Sandi",
                        errorText: _errorText.isNotEmpty ? _errorText : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // Circular 10
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _signIn,
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: 'Belum punya akun? ',
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Daftar di sini.',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/SignUpScreen');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
