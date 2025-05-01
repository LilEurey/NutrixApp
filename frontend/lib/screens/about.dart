import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              // Centered title
              const Center(
                child: Text(
                  'About Nutrix',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Nutrix is your personal meal planning and weight '
                'management assistant, designed to make healthy living '
                'simple, sustainable, and motivating.',
                style: TextStyle(height: 1.6, fontSize: 14),
              ),
              const SizedBox(height: 32),

              _infoRow(
                icon: Icons.restaurant_menu,
                title: 'Meal Plans',
                subtitle:
                    'Nutrix recommends daily meals tailored to your calorie goals and preferences.',
              ),
              const SizedBox(height: 24),

              _infoRow(
                icon: Icons.local_fire_department,
                title: 'Calorie Tracking',
                subtitle:
                    'Automatically track intake and progress toward your weight goals.',
              ),
              const SizedBox(height: 24),

              _infoRow(
                icon: Icons.bar_chart,
                title: 'Progress & Motivation',
                subtitle:
                    'Daily logging, reminders and milestone rewards keep you going.',
              ),
              const SizedBox(height: 32),

              const Text(
                'Why Use Nutrix?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),

              const Text(
                'We built Nutrix to take the stress out of weight loss. '
                'It’s not about restrictions – it’s about smarter, '
                'consistent choices.',
                style: TextStyle(height: 1.6, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Icon(icon, size: 20, color: Colors.black),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(height: 1.5, fontSize: 13.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
