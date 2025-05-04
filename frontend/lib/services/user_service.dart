import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  /// Save or update user data in Firestore
  Future<void> saveUser(AppUser user) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(user.id)
          .set(user.toMap(), SetOptions(merge: true));
      print('✅ User saved to Firestore');
    } catch (e) {
      print('❌ Failed to save user to Firestore: $e');
    }
  }
}
