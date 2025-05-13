import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';

class ViewMoreScreen extends StatelessWidget {
  const ViewMoreScreen({super.key, required String mealType});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final mealType = args?['mealType'] ?? 'Breakfast';
    final breakfastItems =
        args?['breakfastItems'] as List<Map<String, dynamic>>? ?? [];
    final lunchItems = args?['lunchItems'] as List<Map<String, dynamic>>? ?? [];
    final dinnerItems =
        args?['dinnerItems'] as List<Map<String, dynamic>>? ?? [];

    List<Map<String, dynamic>> selectedMeals = [];
    if (mealType == 'Breakfast') {
      selectedMeals = breakfastItems;
    } else if (mealType == 'Lunch') {
      selectedMeals = lunchItems;
    } else {
      selectedMeals = dinnerItems;
    }

    return Scaffold(
      bottomNavigationBar: const BottomNavbar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, size: 24),
              ),
              const SizedBox(height: 16),

              Text(
                mealType,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Nutrix choose the best food for you !',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 12,
                  children:
                      selectedMeals.map((meal) {
                        return _buildFoodCard(
                          imageUrl:
                              meal['imageUrl'] ??
                              'https://via.placeholder.com/100',
                          name: meal['name'] ?? '',
                          kcal: '${meal['kcal']?.toStringAsFixed(0) ?? '0'}',
                          protein:
                              '${meal['protein']?.toStringAsFixed(0) ?? '0'}g',
                          fat: '${meal['fat']?.toStringAsFixed(0) ?? '0'}g',
                          fibre: '${meal['fiber']?.toStringAsFixed(0) ?? '0'}g',
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodCard({
    required String imageUrl,
    required String name,
    required String kcal,
    required String protein,
    required String fat,
    required String fibre,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.fastfood, color: Colors.grey),
                        ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$kcal Kcal',
                  style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Protein',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          protein,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Fat',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          fat,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Fibre',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          fibre,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
