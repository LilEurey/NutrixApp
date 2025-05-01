import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
        context,
        '/authchoice',
      ); // ⬅️ change route if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
    );
  }
}
