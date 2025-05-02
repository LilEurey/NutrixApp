import 'package:flutter/material.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/step_progress.dart';

class FillNameScreen extends StatefulWidget {
  const FillNameScreen({super.key});

  @override
  State<FillNameScreen> createState() => _FillNameScreenState();
}

class _FillNameScreenState extends State<FillNameScreen> {
  final TextEditingController nameController = TextEditingController();

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

              // GOALS Label + Step Progress with top spacing
              Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'GOALS',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const StepProgress(currentStep: 1),
                ],
              ),

              const SizedBox(height: 32),

              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF17414A),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF2F80ED),
                  decorationThickness: 2,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'First, What can we call you?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: nameController,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF004D40),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF004D40),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              NavigationButtons(
                onNext: () {
                  Navigator.pushNamed(context, '/usergoal');
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
