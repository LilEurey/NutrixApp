import 'package:flutter/material.dart';
import 'package:frontend/screens/healthy_habits_screen.dart';
import 'package:frontend/screens/user_goal_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/user_info_screen.dart';
import 'screens/physical_stats_screen.dart';
import 'screens/weekly_goal_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/user_goal_screen.dart';
import 'screens/Barriers_screen.dart';
import 'screens/planmeal_seq_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/healthy_habits_screen.dart';
import 'screens/profile.dart';
import 'screens/account.dart';

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
        fontFamily: 'Poppins',
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const LoginScreen(),
        '/userinfo': (context) => const UserInfoScreen(),
        '/physical': (context) => const PhysicalStatsScreen(),
        '/goal': (context) => const WeeklyGoalScreen(),
        '/account': (context) => const CreateAccountScreen(),
        '/usergoal': (context) => const UserGoalScreen(),
        '/barriers': (context) => const BarriersScreen(),
        '/frequency': (context) => const PlanmealSeqScreen(),
        '/activity': (context) => const ActivityScreen(),
        '/healthy': (context) => const HealthyHabitsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/paccount': (context) => const AccountScreen(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
