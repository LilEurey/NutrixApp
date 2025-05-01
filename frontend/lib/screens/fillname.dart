import 'package:flutter/material.dart';
import '../widgets/navigation_buttons.dart';

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

              // GOALS title
              const Center(
                child: Text(
                  'GOALS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),

              // Step progress bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 30,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.cyan : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
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
                  Navigator.pushNamed(context, '/usergoal'); // Update as needed
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
