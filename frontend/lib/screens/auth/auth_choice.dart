import 'package:flutter/material.dart';

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 TOP BACKGROUND IMAGE
          // Positioned(top: 0, left: 0, child: Image.asset('assets/images/top_curve.png')),

          // 🔵 BOTTOM BACKGROUND IMAGE
          // Positioned(bottom: 0, right: 0, child: Image.asset('assets/images/bottom_curve.png')),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'NUTRIX',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // ✅ Google Sign-In Button using the image
                GestureDetector(
                  onTap: () {
                    // 🔁 Trigger Google Sign-In logic here
                  },
                  child: Image.asset(
                    'assets/images/google_icon.png', // 👈 Your button image
                    width: 200, // Adjust as needed
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
