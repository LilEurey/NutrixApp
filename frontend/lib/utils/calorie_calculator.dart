class CalorieCalculator {
  static double calculateBMR({
    required String gender,
    required int age,
    required double heightCm,
    required double weightKg,
  }) {
    if (gender.toLowerCase() == 'male') {
      return 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
    } else {
      return 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }
  }

  static double getActivityMultiplier(String activityLevel) {
    switch (activityLevel) {
      case 'Not very active':
        return 1.2;
      case 'Lightly active':
        return 1.375;
      case 'Active':
        return 1.55;
      case 'Very active':
        return 1.725;
      default:
        return 1.2;
    }
  }

  static double calculateDeficitFromWeeklyGoal(double weeklyGoalKg) {
    return (weeklyGoalKg.abs() * 7700) / 7;
  }

  static Map<String, double> calculateAll({
    required String gender,
    required int age,
    required double heightCm,
    required double weightKg,
    required String activityLevel,
    required double weeklyGoalKg,
  }) {
    final bmr = calculateBMR(
      gender: gender,
      age: age,
      heightCm: heightCm,
      weightKg: weightKg,
    );

    final multiplier = getActivityMultiplier(activityLevel);
    final tdee = bmr * multiplier;
    final calorieDeficit = calculateDeficitFromWeeklyGoal(weeklyGoalKg);
    final dailyCalorieGoal = tdee - calorieDeficit;
    final waterGoalMl = weightKg * 35;

    return {
      'BMR': double.parse(bmr.toStringAsFixed(2)),
      'TDEE': double.parse(tdee.toStringAsFixed(2)),
      'CalorieDeficit': double.parse(calorieDeficit.toStringAsFixed(2)),
      'DailyCalorieGoal': double.parse(dailyCalorieGoal.toStringAsFixed(2)),
      'WaterGoalMl': double.parse(waterGoalMl.toStringAsFixed(0)),
    };
  }
}
