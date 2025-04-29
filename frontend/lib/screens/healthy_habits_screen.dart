import 'package:flutter/material.dart';
import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';

class HealthyHabitsScreen extends StatefulWidget {
  const HealthyHabitsScreen({super.key});

  @override
  State<HealthyHabitsScreen> createState() => _HealthyHabitsScreenState();
}

class _HealthyHabitsScreenState extends State<HealthyHabitsScreen> {
  final List<String> habits = [
    "🗓️ Plan more meals",
    "🥪 Meal prep and cook",
    "🥦 Eat more vegetables",
    "⛹️ Workout more",
    "🥩 Eat more protein",
    "📱 Track calories",
    "💧 Drink more water",
    "😓 I’m not sure",
  ];

  final Set<String> selectedHabits = {};

  void toggleHabit(String habit) {
    setState(() {
      if (selectedHabits.contains(habit)) {
        selectedHabits.remove(habit);
      } else {
        selectedHabits.add(habit);
      }
    });
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
                  const Text(
                    'GOALS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const StepProgress(currentStep: 5),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Which healthy habits are most important to you?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const Text(
                'Recommended for you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      habits.map((habit) {
                        bool isSelected = selectedHabits.contains(habit);
                        return GestureDetector(
                          onTap: () => toggleHabit(habit),
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? const Color(0xFF00CC99)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                width: 1,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : const Color(0xFF00CC99),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                habit,
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? const Color(0xFF165668)
                                          : const Color(0xFF00CC99),
                                  fontSize: 15,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              NavigationButtons(
                onNext: () => Navigator.pushNamed(context, '/frequency'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
