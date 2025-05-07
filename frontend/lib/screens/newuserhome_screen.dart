import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';

class PersonalizedMealPlanScreen extends StatefulWidget {
  const PersonalizedMealPlanScreen({super.key});

  @override
  State<PersonalizedMealPlanScreen> createState() =>
      _PersonalizedMealPlanScreenState();
}

class _PersonalizedMealPlanScreenState
    extends State<PersonalizedMealPlanScreen> {
  double? bmr;
  double? tdee;
  double? calorieDeficit;
  double? dailyCalorieGoal;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data();

    if (data != null) {
      setState(() {
        bmr = (data['BMR'] as num?)?.toDouble();
        tdee = (data['TDEE'] as num?)?.toDouble();
        calorieDeficit = (data['calorieDeficit'] as num?)?.toDouble();
        dailyCalorieGoal = (data['dailyCalorieGoal'] as num?)?.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
              bmr == null ||
                      tdee == null ||
                      calorieDeficit == null ||
                      dailyCalorieGoal == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      const Center(
                        child: Text(
                          'Your personalized meal plan is ready!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Four Info Cards
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _infoCard(
                            'BMR\n${bmr!.toStringAsFixed(0)} kcal/day',
                            Icons.local_fire_department,
                          ),
                          _infoCard(
                            'TDEE\n${tdee!.toStringAsFixed(0)} kcal/day',
                            Icons.directions_run,
                          ),
                          _infoCard(
                            'Calorie deficit\n${calorieDeficit!.toStringAsFixed(0)} kcal',
                            Icons.track_changes,
                          ),
                          _infoCard(
                            'Daily calorie goal\n${dailyCalorieGoal!.toStringAsFixed(0)} kcal',
                            Icons.water_drop_outlined,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TDEE                                                                   TARGET',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Stack(
                            children: [
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(
                                height: 10,
                                width:
                                    MediaQuery.of(context).size.width *
                                    0.9 *
                                    (dailyCalorieGoal! / tdee!),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${tdee!.toStringAsFixed(0)} kcal'),
                              Text(
                                '${dailyCalorieGoal!.toStringAsFixed(0)} kcal',
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/summary');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFF17414A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: const Text(
                            'Start my meal plan',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _infoCard(String text, IconData icon) {
    return Container(
      width: 160,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
