import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final Future<void> Function()? onNext;

  const NavigationButtons({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Color(0xFF004D40),
          ),
        ),

        ElevatedButton(
          onPressed:
              onNext != null
                  ? () async {
                    await onNext!();
                  }
                  : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF008080),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(120, 48),
          ),
          child: const Text("Next", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
