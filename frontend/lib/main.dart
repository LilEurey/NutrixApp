import 'package:flutter/material.dart';
import 'package:frontend/screens/about.dart';
import 'package:frontend/screens/delete_account.dart';
import 'package:frontend/screens/delete_data.dart' show DeleteDataScreen;
import 'package:frontend/screens/healthy_habits_screen.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/screens/mealsummary.dart';
import 'package:frontend/screens/privacy.dart';
import 'package:frontend/screens/progress_screen.dart';
import 'package:frontend/screens/safety.dart';
import 'package:frontend/screens/user_goal_screen.dart';
import 'package:frontend/screens/viewmore.dart';
import 'package:frontend/screens/welcomepage.dart';
import 'screens/auth/auth_choice.dart';
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
import 'screens/fillname.dart';
import 'screens/newuserhome_screen.dart';
import 'screens/mealsummary.dart';

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
        '/': (context) => const WelcomeScreen(),
        '/homescreen': (context) => const HomeScreen(),
        '/viewmore': (context) => const ViewMoreScreen(),
        '/authchoice': (context) => const AuthChoiceScreen(),
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
        '/fillname': (context) => const FillNameScreen(),
        '/progress': (context) => const ProgressScreen(),
        '/about': (context) => const AboutScreen(),
        '/safety': (context) => const SafetyScreen(),
        '/privacy': (context) => const PrivacySettingsScreen(),
        '/deleteaccount': (context) => const DeleteAccountScreen(),
        '/deletedata': (context) => const DeleteDataScreen(),
        '/newuser': (context) => const PersonalizedMealPlanScreen(),
        '/summary': (context) => const MealSummaryScreen(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
