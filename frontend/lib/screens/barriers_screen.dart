import 'package:flutter/material.dart';
import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';

class BarriersScreen extends StatefulWidget {
  const BarriersScreen({super.key});

  @override
  State<BarriersScreen> createState() => _BarriersScreenState();
}

class _BarriersScreenState extends State<BarriersScreen> {
  final List<String> selectedGoals = [];

  final goals = [
    'Lack of time',
    'Lack of progress',
    'Unrealistic goals',
    'Not knowing what to eat',
    'Lack of meal plan',
    'Inconsistent motivation',
  ];

  void toggleGoal(String goal) {
    setState(() {
      if (selectedGoals.contains(goal)) {
        selectedGoals.remove(goal);
      } else {
        selectedGoals.add(goal);
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

              // GOALS label and step progress
              Column(
                children: const [
                  Text(
                    'GOALS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 12),
                  StepProgress(currentStep: 3), // ✅ Updated step
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                'In the past, What were the barriers to achieving weight loss?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 32),

              const Text(
                'Select all that apply',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 24),

              // Multiple selection goals
              ...goals.map(
                (goal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => toggleGoal(goal),
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
                              selectedGoals.contains(goal)
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
                            selectedGoals.contains(goal)
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color:
                                selectedGoals.contains(goal)
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
                onNext: () {
                  Navigator.pushNamed(context, '/healthy');
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
