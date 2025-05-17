import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String selectedView = 'Daily';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(currentIndex: 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle Buttons
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6F5F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _toggleChip('Daily'),
                    _toggleChip('Weekly'),
                    _toggleChip('Monthly'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ..._getStatsAndContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleChip(String label) {
    final isSelected = label == selectedView;
    return GestureDetector(
      onTap: () => setState(() => selectedView = label),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF004D40) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getStatsAndContent() {
    if (selectedView == 'Weekly') {
      return [
        _subheading("You're making progress!"),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            _StatCard(title: 'Starting weight', value: '66,4kg'),
            _StatCard(title: 'Current weight', value: '65,6kg'),
            _StatCard(title: 'Weight change', value: '-0,8kg'),
            _StatCard(title: 'Days Logged', value: '6/7'),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          'Achievements earned',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        const _AchievementRow(
          icon: Icons.emoji_events,
          label: '5-Day Logging Streak',
        ),
        const _AchievementRow(
          icon: Icons.check_circle,
          label: 'Logged Weight 6 Days',
        ),
        const _AchievementRow(
          icon: Icons.water_drop,
          label: 'Completed 3 Water Goals',
        ),
      ];
    } else if (selectedView == 'Monthly') {
      return [
        _subheading("Keep it up! You're doing amazing."),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            _StatCard(title: 'Starting weight', value: '67,2kg'),
            _StatCard(title: 'Current weight', value: '64,5kg'),
            _StatCard(title: 'Days Logged', value: '22/30'),
            _StatCard(title: 'Longest Streak', value: '8 days'),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          'Milestones',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        const _AchievementRow(
          icon: Icons.trending_down,
          label: '2.5 kg lost in 30 days!',
        ),
        const _AchievementRow(
          icon: Icons.verified,
          label: '20+ Day Logging Badge',
        ),
        const _AchievementRow(
          icon: Icons.water_drop,
          label: 'Hydration Hero\nLogged Water 20 days.',
        ),
      ];
    }

    // Daily view
    return [
      _subheading("One step at a time.\nYou are doing great!"),
      const SizedBox(height: 16),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const [
          _StatCard(title: 'Weight today', value: '66,5kg'),
          _StatCard(title: 'Calories consumed', value: '560/1600'),
        ],
      ),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Water Intake',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '6 ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '/ 8 glasses',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: 6 / 8,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF00D1B2),
              minHeight: 8,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _subheading(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
  );
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _AchievementRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _AchievementRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black),
          const SizedBox(width: 12),
          Flexible(child: Text(label, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
