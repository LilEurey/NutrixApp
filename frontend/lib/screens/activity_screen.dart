import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String? selectedGoal;

  final goals = ['Not very active', 'Lightly active', 'Active', 'Very active'];

  Future<void> _saveActivityLevelAndContinue() async {
    if (selectedGoal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your activity level')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);
      await userDoc.set({
        'activity_level': selectedGoal,
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      Navigator.pushNamed(context, '/userinfo');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not logged in')));
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
              Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'GOALS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const StepProgress(currentStep: 6),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'What is your baseline activity level?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

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

              NavigationButtons(onNext: _saveActivityLevelAndContinue),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
