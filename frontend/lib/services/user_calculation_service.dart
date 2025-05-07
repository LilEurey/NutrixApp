import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/calorie_calculator.dart';

class UserCalculationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> calculateAndStoreCalories(String uid) async {
    final userDoc = _firestore.collection('users').doc(uid);
    final snapshot = await userDoc.get();

    if (!snapshot.exists) return;

    final data = snapshot.data();
    if (data == null ||
        data['gender'] == null ||
        data['age_years'] == null ||
        data['height_cm'] == null ||
        data['weight_kg'] == null ||
        data['activity_level'] == null ||
        data['weekly_goal_kg'] == null) {
      return;
    }

    final gender = data['gender'] as String;
    final age = data['age_years'] as int;
    final heightCm = (data['height_cm'] as num).toDouble();
    final weightKg = (data['weight_kg'] as num).toDouble();
    final activityLevel = data['activity_level'] as String;
    final weeklyGoalKg = (data['weekly_goal_kg'] as num).toDouble();

    final result = CalorieCalculator.calculateAll(
      gender: gender,
      age: age,
      heightCm: heightCm,
      weightKg: weightKg,
      activityLevel: activityLevel,
      weeklyGoalKg: weeklyGoalKg,
    );

    await userDoc.update({
      'BMR': result['BMR'],
      'TDEE': result['TDEE'],
      'calorieDeficit': result['CalorieDeficit'],
      'dailyCalorieGoal': result['DailyCalorieGoal'],
      'waterGoalMl': result['WaterGoalMl'],
    });
  }
}
