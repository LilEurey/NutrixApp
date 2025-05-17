import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';

class UserGoalScreen extends StatefulWidget {
  const UserGoalScreen({super.key});

  @override
  State<UserGoalScreen> createState() => _UserGoalScreenState();
}

class _UserGoalScreenState extends State<UserGoalScreen> {
  String? selectedGoal;
  final goals = ['Lose weight'];
  String userName = 'there'; // fallback name

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        if (data['username'] != null &&
            data['username'].toString().isNotEmpty) {
          setState(() {
            userName = data['username'];
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  'GOALS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const StepProgress(currentStep: 2),
              const SizedBox(height: 24),

              // 👋 Dynamic greeting
              Text(
                'Hey, $userName. Let’s start with your goals.',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),
              const Text(
                'Select the category that fits your goal best.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // 🟩 Selectable goal
              ...goals.map(
                (goal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGoal = goal),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              selectedGoal == goal
                                  ? const Color(0xFF008080)
                                  : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            goal,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            selectedGoal == goal
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color:
                                selectedGoal == goal
                                    ? const Color(0xFF008080)
                                    : Colors.black38,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              NavigationButtons(
                onNext: () => Navigator.pushNamed(context, '/barriers'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
