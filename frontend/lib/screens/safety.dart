import 'package:flutter/material.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.verified_user,
                      size: 60,
                      color: Color(0xFF33BFA6), // Shield color
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Your Safety Matters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // What Nutrix Collects
              const Text(
                'What Nutrix Collects?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              const BulletPoint(text: 'Basic Info (Age, Weight, Height, Activity Level)'),
              const BulletPoint(text: 'Dietary Preferences'),
              const BulletPoint(text: 'Weight Logs & Meal History'),
              const SizedBox(height: 4),
              const Text(
                'Nutrix only collects what’s needed to personalize your experience.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),

              // How Your Data Is Protected
              const Text(
                'How Your Data Is Protected?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              const BulletPoint(
                  text: 'Your data is stored securely and encrypted.'),
              const BulletPoint(
                  text:
                      'Nutrix does not share or sell your information to third parties.'),
              const BulletPoint(
                  text:
                      'You have full control — delete your data anytime from your profile.'),
              const SizedBox(height: 24),

              // Transparency
              const Text(
                'Transparency & Control',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'You can review, update, or delete your personal data anytime from the Profile > Privacy. Settings section.',
              ),
              const SizedBox(height: 24),

              // Our Promise
              const Text(
                'Our Promise',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Nutrix respects your privacy.\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We’re here to help you — not to exploit your data.',
                      style: TextStyle(color: Colors.black54),
                    ),
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

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
