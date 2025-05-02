import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/log_meal.dart';

class MealSummaryScreen extends StatelessWidget {
  const MealSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Your meal summary\nfor today!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),

              // Meal Cards
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    MealCard(
                      imagePath: 'assets/images/meat.png',
                      kcal: 402,
                      title: 'Sliced meat',
                      protein: '7gm',
                      fat: '20gm',
                      fibre: '5gm',
                    ),
                    SizedBox(width: 16),
                    MealCard(
                      imagePath: 'assets/images/milk.png',
                      kcal: 150,
                      title: 'Milk (1 cup)',
                      protein: '8gm',
                      fat: '5gm',
                      fibre: '12gm',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              const Divider(thickness: 1),
              const SizedBox(height: 16),
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                '552 Kcal  |  protein 15kg  |  fat 25kg  |  carbs 17kg',
                style: TextStyle(fontSize: 15),
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const BreakfastLoggedDialog();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF17414A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Log as breakfast',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String imagePath;
  final int kcal;
  final String title;
  final String protein;
  final String fat;
  final String fibre;

  const MealCard({
    super.key,
    required this.imagePath,
    required this.kcal,
    required this.title,
    required this.protein,
    required this.fat,
    required this.fibre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$kcal Kcal',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF01F9C6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Protein $protein'),
          Text('Fat $fat'),
          Text('Fibre $fibre'),
        ],
      ),
    );
  }
}
