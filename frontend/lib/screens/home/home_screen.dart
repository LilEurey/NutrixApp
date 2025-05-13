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
  double dailyCalorieGoal = 0.0;
  double goalWeightKg = 0.0;
  Map<String, List<Map<String, dynamic>>> mealData = {
    'Breakfast': [],
    'Lunch': [],
    'Dinner': [],
  };

  String selectedMeal = 'Breakfast';
  String username = '';
  double waterGoalMl = 0.0;
  double weightKg = 0.0;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.wait([_loadUserData(), _loadMealData()]).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
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
        dailyCalorieGoal = (data['dailyCalorieGoal'] ?? 0).toDouble();
        waterGoalMl = (data['waterGoalMl'] ?? 0).toDouble();
      });
    }
  }

  Future<void> _loadMealData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('food_items').get();

    final allItems = querySnapshot.docs.map((doc) => doc.data()).toList();

    // Filter by FoodID prefix
    final breakfastFoods =
        allItems
            .where((item) => item['foodId']?.startsWith('B') ?? false)
            .toList();
    final drinks =
        allItems
            .where((item) => item['foodId']?.startsWith('D') ?? false)
            .toList();
    final lunchDinnerFoods =
        allItems
            .where((item) => item['foodId']?.startsWith('F') ?? false)
            .toList();

    breakfastFoods.shuffle();
    drinks.shuffle();
    lunchDinnerFoods.shuffle();

    setState(() {
      mealData['Breakfast'] = [...breakfastFoods.take(5), ...drinks.take(5)];
      mealData['Lunch'] = [
        ...lunchDinnerFoods.take(5),
        ...drinks.skip(5).take(5),
      ];
      mealData['Dinner'] = [
        ...lunchDinnerFoods.skip(10).take(5),
        ...drinks.skip(10).take(5),
      ];
    });
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    return SizedBox(
      width: 170,
      height: 260,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage:
                  (meal['imageUrl'] != null &&
                          meal['imageUrl'].toString().isNotEmpty)
                      ? NetworkImage(meal['imageUrl'])
                      : const AssetImage('assets/images/placeholder.png')
                          as ImageProvider,
              onBackgroundImageError:
                  (_, __) => const Icon(Icons.broken_image, size: 45),
            ),
            const SizedBox(height: 10),
            Text(
              '${(meal['kcal'] ?? 0).toString()} Kcal',
              style: const TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      meal['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.add, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("Protein", style: TextStyle(fontSize: 10)),
                    Text(
                      '${(meal['protein'] ?? 0).toString()}g',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Fat", style: TextStyle(fontSize: 10)),
                    Text(
                      '${(meal['fat'] ?? 0).toString()}g',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Fibre", style: TextStyle(fontSize: 10)),
                    Text(
                      '${(meal['fiber'] ?? 0).toString()}g',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
                          StatCard(
                            title: 'Calorie',
                            value: '0 kcal',
                            subtext:
                                'of ${dailyCalorieGoal.toStringAsFixed(0)}',
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
                          StatCard(
                            title: 'Water',
                            value: '0ml',
                            subtext: '${waterGoalMl.toStringAsFixed(0)}ml',
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
                                () => Navigator.pushNamed(
                                  context,
                                  '/viewmore',
                                  arguments: {
                                    'mealType': selectedMeal,
                                    'breakfastItems': mealData['Breakfast'],
                                    'lunchItems': mealData['Lunch'],
                                    'dinnerItems': mealData['Dinner'],
                                  },
                                ),
                            child: const Text(
                              'View more >',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 260,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:
                              mealData[selectedMeal]
                                  ?.map((meal) => _buildMealCard(meal))
                                  .toList() ??
                              [],
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
