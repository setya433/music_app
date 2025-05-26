import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar sebagai latar belakang
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcomeImage.jpg', // Ganti dengan path gambar kamu
              fit: BoxFit.cover, // Menutupi seluruh layar
            ),
          ),
          
          // Warna overlay gelap agar teks lebih terbaca (opsional)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Konten utama
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'WELCOME TO WENOIZE MUSIC APP',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'WENOIZ is a community music platform owned by the Polines art community, especially in the field of music, to become a platform for publishing music produced by bands or soloists from Polytechnic State of Semarang.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),

                    // Tombol Sign In
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) =>  SignInScreen()),
                        );
                      },
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Colors.,
                      //   foregroundColor: Colors.black,
                      //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      // ),
                      child: const Text('SIGN IN'),
                    ),
                    const SizedBox(height: 16),

                    // Tombol Sign Up
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) =>  SignUpScreen()),
                        );
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
