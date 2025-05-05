import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/measurement_field.dart';

class PhysicalStatsScreen extends StatefulWidget {
  const PhysicalStatsScreen({super.key});

  @override
  State<PhysicalStatsScreen> createState() => _PhysicalStatsScreenState();
}

class _PhysicalStatsScreenState extends State<PhysicalStatsScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final goalWeightController = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveDataAndContinue() async {
    final user = FirebaseAuth.instance.currentUser;
    final height = double.tryParse(heightController.text.trim());
    final weight = double.tryParse(weightController.text.trim());
    final goalWeight = double.tryParse(goalWeightController.text.trim());

    if (user == null ||
        height == null ||
        weight == null ||
        goalWeight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please enter valid numbers in all fields.'),
        ),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      await docRef.set({
        'height_cm': height,
        'weight_kg': weight,
        'goal_weight_kg': goalWeight,
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      Navigator.pushNamed(context, '/goal');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ Failed to save data: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const StepProgress(currentStep: 8),

                  const SizedBox(height: 32),
                  const Text(
                    'Just a few more questions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  MeasurementField(
                    controller: heightController,
                    label: 'What is your height?',
                    unit: 'cm',
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: weightController,
                    label: 'How much do you weight?',
                    unit: 'kg',
                  ),
                  const SizedBox(height: 16),
                  MeasurementField(
                    controller: goalWeightController,
                    label: 'What is your goal weight?',
                    unit: 'kg',
                  ),

                  const Spacer(),
                  NavigationButtons(onNext: _saveDataAndContinue),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
