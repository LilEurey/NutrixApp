import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';

class ViewMoreScreen extends StatelessWidget {
  const ViewMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

              const Text(
                'Breakfast',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  mainAxisSpacing: 16,
                  children: [
                    _buildFoodCard(
                      imageUrl:
                          'https://via.placeholder.com/100x100.png?text=Lamb',
                      name: 'Grilled Lamb',
                      kcal: '390',
                      protein: '7g',
                      fat: '20g',
                      fibre: '5g',
                    ),
                    _buildFoodCard(
                      imageUrl:
                          'https://via.placeholder.com/100x100.png?text=Meat',
                      name: 'Sliced meat',
                      kcal: '402',
                      protein: '7g',
                      fat: '20g',
                      fibre: '5g',
                    ),
                    _buildFoodCard(
                      imageUrl:
                          'https://via.placeholder.com/100x100.png?text=Chicken',
                      name: 'Roast chicken',
                      kcal: '420',
                      protein: '7g',
                      fat: '20g',
                      fibre: '5g',
                    ),
                    _buildFoodCard(
                      imageUrl:
                          'https://via.placeholder.com/100x100.png?text=Kebab',
                      name: 'Meat Kebab',
                      kcal: '410',
                      protein: '7g',
                      fat: '20g',
                      fibre: '5g',
                    ),
                  ],
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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$kcal Kcal',
            style: const TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Protein $protein'),
          Text('Fat $fat'),
          Text('Fibre $fibre'),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
