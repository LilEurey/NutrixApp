import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../storage/meal_summary_storage.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/log_meal.dart';

class MealSummaryScreen extends StatefulWidget {
  const MealSummaryScreen({super.key});

  @override
  State<MealSummaryScreen> createState() => _MealSummaryScreenState();
}

class _MealSummaryScreenState extends State<MealSummaryScreen> {
  List<Map<String, dynamic>> _loggedMeals = [];
  double _loggedKcal = 0, _loggedProtein = 0, _loggedFat = 0, _loggedFibre = 0;

  @override
  void initState() {
    super.initState();
    _loadLoggedMeals();
  }

  void _loadLoggedMeals() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final today = DateTime.now();
    final formattedDate =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final userMealsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('logged_meals')
        .doc(formattedDate);

    final doc = await userMealsRef.get();

    if (doc.exists) {
      final data = doc.data();
      final List<Map<String, dynamic>> meals = List<Map<String, dynamic>>.from(
        data?['meals'] ?? [],
      );
      double kcal = (data?['totalKcal'] ?? 0).toDouble();
      double protein = (data?['totalProtein'] ?? 0).toDouble();
      double fat = (data?['totalFat'] ?? 0).toDouble();
      double fibre = (data?['totalFibre'] ?? 0).toDouble();

      setState(() {
        _loggedMeals = meals;
        _loggedKcal = kcal;
        _loggedProtein = protein;
        _loggedFat = fat;
        _loggedFibre = fibre;
      });
    }
  }

  void _logMeals() async {
    final mealsToLog = List<Map<String, dynamic>>.from(
      MealSummaryStorage().getMeals(),
    );

    double kcal = 0, protein = 0, fat = 0, fibre = 0;
    for (var meal in mealsToLog) {
      kcal += (meal['kcal'] ?? 0).toDouble();
      protein += (meal['protein'] ?? 0).toDouble();
      fat += (meal['fat'] ?? 0).toDouble();
      fibre += (meal['fiber'] ?? 0).toDouble();
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userMealsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('logged_meals');

      final today = DateTime.now();
      final formattedDate =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      final docSnapshot = await userMealsRef.doc(formattedDate).get();
      List<Map<String, dynamic>> existingMeals = [];
      double existingKcal = 0,
          existingProtein = 0,
          existingFat = 0,
          existingFibre = 0;

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        existingMeals = List<Map<String, dynamic>>.from(data['meals'] ?? []);
        existingKcal = (data['totalKcal'] ?? 0).toDouble();
        existingProtein = (data['totalProtein'] ?? 0).toDouble();
        existingFat = (data['totalFat'] ?? 0).toDouble();
        existingFibre = (data['totalFibre'] ?? 0).toDouble();
      }

      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      final dailyGoal = (userDoc.data()?['dailyCalorieGoal'] ?? 0).toDouble();
      final currentTotal = existingKcal + kcal;

      if (currentTotal > dailyGoal) {
        // Show alert dialog and exit early
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Cannot Log Meal'),
              content: const Text('The total calories exceed your remaining calorie goal.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      final updatedMeals = [...existingMeals, ...mealsToLog];

      final newRemaining = dailyGoal - currentTotal;

      await userMealsRef.doc(formattedDate).set({
        'meals': updatedMeals,
        'totalKcal': currentTotal,
        'totalProtein': existingProtein + protein,
        'totalFat': existingFat + fat,
        'totalFibre': existingFibre + fibre,
        'caloriesRemaining': newRemaining,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'caloriesRemaining': newRemaining},
      );
    }

    MealSummaryStorage().clearMeals();
    _loadLoggedMeals();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMeals = MealSummaryStorage().getMeals();
    double totalKcal = 0, totalProtein = 0, totalFat = 0, totalFibre = 0;

    for (var meal in selectedMeals) {
      totalKcal += (meal['kcal'] ?? 0).toDouble();
      totalProtein += (meal['protein'] ?? 0).toDouble();
      totalFat += (meal['fat'] ?? 0).toDouble();
      totalFibre += (meal['fiber'] ?? 0).toDouble();
    }

    return Scaffold(
      bottomNavigationBar: const BottomNavbar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      'Your meal summary\nfor today!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: selectedMeals
                            .map(
                              (meal) => Column(
                                children: [
                                  MealCard(
                                    imagePath: meal['imageUrl'] ?? '',
                                    kcal: (meal['kcal'] ?? 0).toDouble(),
                                    title: meal['name'] ?? '',
                                    protein: '${(meal['protein'] ?? 0).toDouble().toStringAsFixed(0)}g',
                                    fat: '${(meal['fat'] ?? 0).toDouble().toStringAsFixed(0)}g',
                                    fibre: '${(meal['fiber'] ?? 0).toDouble().toStringAsFixed(0)}g',
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        MealSummaryStorage().selectedMeals.remove(meal);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(thickness: 1),
                    const SizedBox(height: 16),
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${totalKcal.toStringAsFixed(0)} Kcal  |  protein ${totalProtein.toStringAsFixed(0)}g  |  fat ${totalFat.toStringAsFixed(0)}g  |  fibre ${totalFibre.toStringAsFixed(0)}g',
                      style: const TextStyle(fontSize: 15),
                    ),
                    if (_loggedMeals.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Logged Totals',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_loggedKcal.toStringAsFixed(0)} Kcal  |  protein ${_loggedProtein.toStringAsFixed(0)}g  |  fat ${_loggedFat.toStringAsFixed(0)}g  |  fibre ${_loggedFibre.toStringAsFixed(0)}g',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Logged Meals',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              _loggedMeals
                                  .map(
                                    (meal) => MealCard(
                                      imagePath: meal['imageUrl'] ?? '',
                                      kcal: (meal['kcal'] ?? 0).toDouble(),
                                      title: meal['name'] ?? '',
                                      protein:
                                          '${(meal['protein'] ?? 0).toDouble().toStringAsFixed(0)}g',
                                      fat:
                                          '${(meal['fat'] ?? 0).toDouble().toStringAsFixed(0)}g',
                                      fibre:
                                          '${(meal['fiber'] ?? 0).toDouble().toStringAsFixed(0)}g',
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const BreakfastLoggedDialog();
                            },
                          );
                          _logMeals();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF17414A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Log Today\'s Meals',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String imagePath;
  final double kcal;
  final String title;
  final String protein;
  final String fat;
  final String fibre;

  const MealCard({
    super.key,
    required this.imagePath,
    required this.kcal,
    required this.title,
    required this.protein,
    required this.fat,
    required this.fibre,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (imagePath.startsWith('http')) {
      imageWidget = Image.network(
        imagePath,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Image.asset(
        imagePath,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    }

    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: imageWidget,
          ),
          const SizedBox(height: 12),
          Text(
            '${kcal.toStringAsFixed(0)} Kcal',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF01F9C6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Protein $protein'),
          Text('Fat $fat'),
          Text('Fibre $fibre'),
        ],
      ),
    );
  }
}
