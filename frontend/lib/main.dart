import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/user_info_screen.dart';
import 'screens/physical_stats_screen.dart';
import 'screens/weekly_goal_screen.dart';
import 'screens/create_account_screen.dart';
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
      ),

      // Start the app on the Profile screen:
      initialRoute: '/profile',

      routes: {
        '/':         (context) => const LoginScreen(),
        '/userinfo': (context) => const UserInfoScreen(),
        '/physical': (context) => const PhysicalStatsScreen(),
        '/goal':     (context) => const WeeklyGoalScreen(),
        '/account':  (context) => const CreateAccountScreen(),
        '/profile':  (context) => const ProfileScreen(),
        '/paccount':  (context) => const AccountScreen(),
      },
 
      debugShowCheckedModeBanner: false,
    );
  }
}
