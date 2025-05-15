import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveMealsToFirestore(List<Map<String, dynamic>> meals) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final now = DateTime.now();
  final today = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

  final docRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .collection('loggedMeals')
    .doc(today);

  await docRef.set({
    'meals': meals,
    'timestamp': FieldValue.serverTimestamp(),
  });
}