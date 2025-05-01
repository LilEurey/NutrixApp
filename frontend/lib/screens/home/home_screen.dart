import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(currentIndex: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good morning',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const Text(
                'Drive,',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatCard(
                    title: 'Calorie',
                    value: '0 kcal',
                    subtext: 'of 1600',
                    icon: Icons.local_fire_department,
                    progress: 0.0,
                  ),
                  StatCard(
                    title: 'Target\nWeight',
                    value: '0%',
                    subtext: '62kg\n60kg',
                    icon: Icons.track_changes,
                    progress: 0.0,
                  ),
                  StatCard(
                    title: 'Water',
                    value: '0ml',
                    subtext: '1728ml',
                    icon: Icons.water_drop,
                    progress: 0.0,
                    isWaterCard: true,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                "Today's meal",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Column(
                    children: [
                      Text(
                        'Breakfast',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      CircleAvatar(radius: 3, backgroundColor: Colors.teal),
                    ],
                  ),
                  Text('Lunch', style: TextStyle(color: Colors.grey)),
                  Text('Dinner', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'For you',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/viewmore');
                    },
                    child: const Text(
                      'View more >',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 210,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildMealCard(
                      imageUrl:
                          'https://via.placeholder.com/100x100.png?text=Meat',
                      name: 'Sliced meat',
                      kcal: '402',
                      protein: '7g',
                      fat: '20g',
                      fibre: '5g',
                    ),
                    _buildMealCard(
                      imageUrl:
                          'https://via.placeholder.com/100x100.png?text=Milk',
                      name: 'Milk (1 cup)',
                      kcal: '150',
                      protein: '8g',
                      fat: '5g',
                      fibre: '12g',
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

  static Widget _buildMealCard({
    required String imageUrl,
    required String name,
    required String kcal,
    required String protein,
    required String fat,
    required String fibre,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 40,
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
