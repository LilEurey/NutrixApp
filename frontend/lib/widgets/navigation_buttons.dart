import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback onNext;
  const NavigationButtons({required this.onNext, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF004D40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(120, 48),
          ),
          child: const Text("Next"),
        ),
      ],
    );
  }
}
