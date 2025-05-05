import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String selectedGender = '';
  final TextEditingController ageController = TextEditingController();
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              const StepProgress(currentStep: 7),

              const SizedBox(height: 32),
              const Text(
                'Tell us a bit about yourself',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please select which sex we should use to calculate the calorie needs.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: GenderButton(
                      label: 'Male',
                      isSelected: selectedGender == 'Male',
                      onTap: () {
                        setState(() {
                          selectedGender = 'Male';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GenderButton(
                      label: 'Female',
                      isSelected: selectedGender == 'Female',
                      onTap: () {
                        setState(() {
                          selectedGender = 'Female';
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'How old are you?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Where do you live?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: selectedLocation,
                items:
                    ['Bangkok', 'Chiang Mai', 'Phuket']
                        .map(
                          (city) =>
                              DropdownMenuItem(value: city, child: Text(city)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),

              const Spacer(),

              NavigationButtons(
                onNext: () async {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user != null &&
                      selectedGender.isNotEmpty &&
                      ageController.text.isNotEmpty) {
                    final userDoc = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid);

                    await userDoc.set({
                      'gender': selectedGender,
                      'age_years': int.tryParse(ageController.text.trim()),
                      'updated_at': FieldValue.serverTimestamp(),
                    }, SetOptions(merge: true));

                    Navigator.pushNamed(context, '/physical');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select gender and enter age'),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.teal : Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
