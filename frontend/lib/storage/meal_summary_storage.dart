class MealSummaryStorage {
  // Singleton instance
  static final MealSummaryStorage _instance = MealSummaryStorage._internal();

  factory MealSummaryStorage() {
    return _instance;
  }

  MealSummaryStorage._internal();

  // List of selected meals
  final List<Map<String, dynamic>> _selectedMeals = [];

  void addMeal(Map<String, dynamic> meal) {
    _selectedMeals.add(meal);
  }

  List<Map<String, dynamic>> get selectedMeals => _selectedMeals;

  void clearMeals() {
    _selectedMeals.clear();
  }

  List<Map<String, dynamic>> getMeals() {
    return _selectedMeals;
  }

  double getTotalCalories() {
    double total = 0.0;
    for (var meal in _selectedMeals) {
      total += (meal['kcal'] ?? 0).toDouble();
    }
    return total;
  }
}
