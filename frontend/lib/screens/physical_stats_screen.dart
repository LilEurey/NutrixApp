import 'package:flutter/material.dart';
import '../widgets/step_progress.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/measurement_field.dart';

class PhysicalStatsScreen extends StatefulWidget {
  const PhysicalStatsScreen({super.key});

  @override
  State<PhysicalStatsScreen> createState() => _PhysicalStatsScreenState();
}

class _PhysicalStatsScreenState extends State<PhysicalStatsScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final goalWeightController = TextEditingController();

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
              // GOALS label + progress bar
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
                  const StepProgress(currentStep: 4),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Just a few more questions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              MeasurementField(
                controller: heightController,
                label: 'What is your height?',
                unit: 'cm',
              ),
              const SizedBox(height: 16),
              MeasurementField(
                controller: weightController,
                label: 'How much do you weigh?',
                unit: 'kg',
              ),
              const SizedBox(height: 16),
              MeasurementField(
                controller: goalWeightController,
                label: 'What is your goal weight?',
                unit: 'kg',
              ),
              const Spacer(),
              NavigationButtons(
                onNext:
                    () => Navigator.pushNamed(
                      context,
                      '/goal',
                    ), // update if needed
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
