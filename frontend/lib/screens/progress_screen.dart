import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/bottom_navbar.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String selectedView = 'Daily';
  final TextEditingController _weightController = TextEditingController();
  List<Map<String, dynamic>> _weightHistory = [];

  @override
  void initState() {
    super.initState();
    _loadWeightHistory();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _logWeight() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final weight = double.tryParse(_weightController.text);
    if (weight == null) return;

    final today = DateTime.now();
    final formattedDate = _formatDate(today);

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('weight_logs')
        .doc(formattedDate);

    final existingLog = await docRef.get();
    if (existingLog.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have already logged your weight today.'),
        ),
      );
      return;
    }

    await docRef.set({
      'weight': weight,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _weightController.clear();
    _loadWeightHistory();
  }

  Future<void> _loadWeightHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('weight_logs')
            .orderBy('timestamp', descending: true)
            .limit(30)
            .get();

    setState(() {
      _weightHistory =
          snapshot.docs
              .map(
                (doc) => {
                  'date': doc.id,
                  'weight': (doc.data()['weight'] ?? 0).toString(),
                },
              )
              .toList();
    });
  }

  Stream<DocumentSnapshot> _getLoggedMealTodayStream() {
    final user = FirebaseAuth.instance.currentUser;
    final today = DateTime.now();
    final formattedDate = _formatDate(today);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('logged_meals')
        .doc(formattedDate)
        .snapshots();
  }

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
                  children: [_toggleChip('Daily')],
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
    // Daily view
    return [
      _subheading("One step at a time.\nYou are doing great!"),
      const SizedBox(height: 16),
      const SizedBox(height: 16),
      const Text(
        'Log your weight today:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter weight (kg)',
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(onPressed: _logWeight, child: const Text('Log')),
        ],
      ),
      const SizedBox(height: 16),
      const Text(
        'Weight History',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),
      Container(
        height: 120,
        child: ListView.builder(
          itemCount: _weightHistory.length,
          itemBuilder: (context, index) {
            final entry = _weightHistory[index];
            return Text('${entry['date']}: ${entry['weight']}kg');
          },
        ),
      ),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _StatCard(
            title: 'Weight today',
            value:
                _weightHistory.isNotEmpty
                    ? '${_weightHistory.first['weight']}kg'
                    : 'N/A',
          ),
          FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseAuth.instance.currentUser == null
                    ? Future.value(null)
                    : FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
            builder: (context, userSnapshot) {
              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                return const _StatCard(
                  title: 'Calories consumed',
                  value: '0 / 0 kcal',
                );
              }

              final userData =
                  userSnapshot.data!.data() as Map<String, dynamic>;
              final dailyGoal = (userData['dailyCalorieGoal'] ?? 0).toDouble();

              return StreamBuilder<DocumentSnapshot>(
                stream: _getLoggedMealTodayStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return _StatCard(
                      title: 'Calories consumed',
                      value: '0 kcal / ${dailyGoal.toStringAsFixed(0)} kcal',
                    );
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  final totalKcal =
                      (data != null && data.containsKey('totalKcal'))
                          ? (data['totalKcal'] ?? 0).toDouble()
                          : 0.0;

                  return _StatCard(
                    title: 'Calories consumed',
                    value:
                        '${totalKcal.toStringAsFixed(0)} / ${dailyGoal.toStringAsFixed(0)} kcal',
                  );
                },
              );
            },
          ),
        ],
      ),
      const SizedBox(height: 24),
      FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const SizedBox.shrink();
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final waterGoalMl = data['waterGoalMl'] ?? 0;

          return Container(
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
                Row(
                  children: const [
                    Icon(Icons.water_drop, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Water Intake',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$waterGoalMl ml',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
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
