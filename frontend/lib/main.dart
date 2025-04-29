import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/user_info_screen.dart';
import 'screens/physical_stats_screen.dart';
import 'screens/weekly_goal_screen.dart';
import 'screens/create_account_screen.dart';

void main() {
  runApp(const NutrixApp());
}

class NutrixApp extends StatelessWidget {
  const NutrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrix App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/userinfo': (context) => const UserInfoScreen(),
        '/physical': (context) => const PhysicalStatsScreen(),
        '/goal': (context) => const WeeklyGoalScreen(),
        '/account': (context) => const CreateAccountScreen(), //ex
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
