import 'package:flutter/material.dart';

class StepProgress extends StatelessWidget {
  final int currentStep;
  const StepProgress({required this.currentStep, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(10, (index) {
        return Container(
          width: 30,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color:
                index < currentStep
                    ? const Color(0xFF01F9C6)
                    : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
