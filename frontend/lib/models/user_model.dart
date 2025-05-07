class AppUser {
  final String id;
  final String username;
  final String email;
  final String authProvider;
  final String? gender;
  final int? ageYears;
  final double? heightCm;
  final double? weightKg;
  final double? goalWeightKg;
  final double? weeklyGoalKg;
  final String? activityLevel;
  final String? profilePictureUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? bmr;
  final double? tdee;
  final double? calorieDeficit;
  final double? dailyCalorieGoal;
  final double? waterGoalMl;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    required this.authProvider,
    this.gender,
    this.ageYears,
    this.heightCm,
    this.weightKg,
    this.goalWeightKg,
    this.weeklyGoalKg,
    this.activityLevel,
    this.profilePictureUrl,
    required this.createdAt,
    required this.updatedAt,
    this.bmr,
    this.tdee,
    this.calorieDeficit,
    this.dailyCalorieGoal,
    this.waterGoalMl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'auth_provider': authProvider,
      'gender': gender,
      'age_years': ageYears,
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'goal_weight_kg': goalWeightKg,
      'weekly_goal_kg': weeklyGoalKg,
      'activity_level': activityLevel,
      'profile_picture_url': profilePictureUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'BMR': bmr,
      'TDEE': tdee,
      'calorieDeficit': calorieDeficit,
      'dailyCalorieGoal': dailyCalorieGoal,
      'waterGoalMl': waterGoalMl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      authProvider: map['auth_provider'],
      gender: map['gender'],
      ageYears: map['age_years'],
      heightCm: (map['height_cm'] as num?)?.toDouble(),
      weightKg: (map['weight_kg'] as num?)?.toDouble(),
      goalWeightKg: (map['goal_weight_kg'] as num?)?.toDouble(),
      weeklyGoalKg: (map['weekly_goal_kg'] as num?)?.toDouble(),
      activityLevel: map['activity_level'],
      profilePictureUrl: map['profile_picture_url'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      bmr: (map['BMR'] as num?)?.toDouble(),
      tdee: (map['TDEE'] as num?)?.toDouble(),
      calorieDeficit: (map['calorieDeficit'] as num?)?.toDouble(),
      dailyCalorieGoal: (map['dailyCalorieGoal'] as num?)?.toDouble(),
      waterGoalMl: (map['waterGoalMl'] as num?)?.toDouble(),
    );
  }
}
