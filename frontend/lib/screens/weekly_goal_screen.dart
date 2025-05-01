import 'package:flutter/material.dart';
import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';

class WeeklyGoalScreen extends StatefulWidget {
  const WeeklyGoalScreen({super.key});

  @override
  State<WeeklyGoalScreen> createState() => _WeeklyGoalScreenState();
}

class _WeeklyGoalScreenState extends State<WeeklyGoalScreen> {
  String? selectedGoal;

  final goals = [
    'lose 0.2kg per week',
    'lose 0.5kg per week',
    'lose 0.8kg per week',
    'lose 1kg per week',
  ];

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
              // GOALS label + step progress
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
                  const StepProgress(currentStep: 9),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'What is your weekly goal?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
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
              NavigationButtons(
                onNext: () => Navigator.pushNamed(context, '/account'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
