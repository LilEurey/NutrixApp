import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/stat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, List<Map<String, String>>> mealData = {
    'Breakfast': [
      {
        'imageUrl': 'https://via.placeholder.com/100x100.png?text=Meat',
        'name': 'Sliced meat',
        'kcal': '402',
        'protein': '7g',
        'fat': '20g',
        'fibre': '5g',
      },
      {
        'imageUrl': 'https://via.placeholder.com/100x100.png?text=Milk',
        'name': 'Milk (1 cup)',
        'kcal': '150',
        'protein': '8g',
        'fat': '5g',
        'fibre': '12g',
      },
    ],
    'Lunch': [
      {
        'imageUrl': 'https://via.placeholder.com/100x100.png?text=Salad',
        'name': 'Chicken Salad',
        'kcal': '320',
        'protein': '25g',
        'fat': '10g',
        'fibre': '8g',
      },
    ],
    'Dinner': [
      {
        'imageUrl': 'https://via.placeholder.com/100x100.png?text=Soup',
        'name': 'Vegetable Soup',
        'kcal': '180',
        'protein': '6g',
        'fat': '3g',
        'fibre': '4g',
      },
    ],
  };

  String selectedMeal = 'Breakfast';
  String username = '';
  double weightKg = 0.0;
  double goalWeightKg = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    final data = doc.data();
    if (data != null) {
      setState(() {
        username = data['username'] ?? '';
        weightKg = (data['weight_kg'] ?? 0).toDouble();
        goalWeightKg = (data['goal_weight_kg'] ?? 0).toDouble();
        _isLoading = false;
      });
    }
  }

  Widget _buildMealCard({
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
          const Align(
            alignment: Alignment.bottomRight,
            child: Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(currentIndex: 0),
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good morning',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$username,',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StatCard(
                            title: 'Calorie',
                            value: '0 kcal',
                            subtext: 'of 1600',
                            icon: Icons.local_fire_department,
                            progress: 0.0,
                          ),
                          StatCard(
                            title: 'Target\nWeight',
                            value: '${weightKg.toStringAsFixed(0)}kg',
                            subtext:
                                '${goalWeightKg.toStringAsFixed(0)}kg goal',
                            icon: Icons.track_changes,
                            progress: 0.0,
                          ),
                          const StatCard(
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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            ['Breakfast', 'Lunch', 'Dinner'].map((meal) {
                              final isSelected = selectedMeal == meal;
                              return GestureDetector(
                                onTap:
                                    () => setState(() => selectedMeal = meal),
                                child: Column(
                                  children: [
                                    Text(
                                      meal,
                                      style: TextStyle(
                                        fontWeight:
                                            isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        color:
                                            isSelected
                                                ? Colors.black
                                                : Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (isSelected)
                                      const CircleAvatar(
                                        radius: 3,
                                        backgroundColor: Colors.teal,
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
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
                            onTap:
                                () => Navigator.pushNamed(context, '/viewmore'),
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
                          children:
                              mealData[selectedMeal]!
                                  .map(
                                    (meal) => _buildMealCard(
                                      imageUrl: meal['imageUrl']!,
                                      name: meal['name']!,
                                      kcal: meal['kcal']!,
                                      protein: meal['protein']!,
                                      fat: meal['fat']!,
                                      fibre: meal['fibre']!,
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
