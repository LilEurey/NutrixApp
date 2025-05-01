import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // Detects taps anywhere
        onTap: () {
          Navigator.pushReplacementNamed(context, '/authchoice');
        },
        child: Stack(
          children: [
            // 🔵 TOP BACKGROUND IMAGE
            // Positioned(top: 0, left: 0, child: Image.asset('assets/images/top_bg.png'))

            // 🔵 BOTTOM BACKGROUND IMAGE
            // Positioned(bottom: 0, right: 0, child: Image.asset('assets/images/bottom_bg.png'))
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  Image.asset(
                    'assets/images/nutrix_logo.png',
                    width: 100,
                    height: 100,
                  ),

                  const SizedBox(height: 12),
                  const Text(
                    'NUTRIX',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Choose better, live better!',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
