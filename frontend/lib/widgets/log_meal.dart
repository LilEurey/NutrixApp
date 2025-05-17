import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../storage/meal_summary_storage.dart';

class BreakfastLoggedDialog extends StatefulWidget {
  const BreakfastLoggedDialog({super.key});

  @override
  State<BreakfastLoggedDialog> createState() => _BreakfastLoggedDialogState();
}

class _BreakfastLoggedDialogState extends State<BreakfastLoggedDialog> {
  double totalCalories = 0;
  double remainingCalories = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCalorieData();
  }

  Future<void> _fetchCalorieData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final dailyGoal = (userDoc.data()?['dailyCalorieGoal'] ?? 0).toDouble();

    final today = DateTime.now();
    final formattedDate = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final loggedDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('logged_meals')
        .doc(formattedDate)
        .get();

    final loggedKcal = (loggedDoc.data()?['totalKcal'] ?? 0).toDouble();
    final addedCalories = MealSummaryStorage().getTotalCalories();
    final remainingAllowed = dailyGoal - loggedKcal;

    if (addedCalories > remainingAllowed) {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 40),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Cannot Log Meal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You only have ${remainingAllowed.toStringAsFixed(0)} Kcal remaining.\nRemove some items to proceed.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close alert
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF17414A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
      return; // Stop further execution entirely
    }

    final remaining = dailyGoal - loggedKcal - addedCalories;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('logged_meals')
        .doc(formattedDate)
        .set({
      'caloriesRemaining': remaining,
    }, SetOptions(merge: true));

    setState(() {
      totalCalories = addedCalories;
      remainingCalories = remaining;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child:
            isLoading
                ? const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                )
                : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 60,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Meals Logged',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${totalCalories.toStringAsFixed(0)} Kcal added\n'
                      'Calories remaining: ${remainingCalories.toStringAsFixed(0)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF17414A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
