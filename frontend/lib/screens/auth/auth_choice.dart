import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn =
          kIsWeb
              ? GoogleSignIn(
                clientId:
                    '334845933057-96u8dj45mqlb8tu7s3b9dh3bc7fg195f.apps.googleusercontent.com',
              )
              : GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print('User cancelled sign-in');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final userExists = await checkIfUserExists(firebaseUser.uid);
        if (userExists) {
          Navigator.pushReplacementNamed(context, '/homescreen');
        } else {
          // Save minimal user info now
          await saveInitialUser(firebaseUser);
          Navigator.pushReplacementNamed(context, '/fillname');
        }
      } else {
        print('❌ Firebase user is null');
      }
    } catch (e) {
      print('❌ Google sign-in failed: $e');
    }
  }

  Future<bool> checkIfUserExists(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }

  Future<void> saveInitialUser(User firebaseUser) async {
    final newUser = AppUser(
      id: firebaseUser.uid,
      username: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      authProvider: firebaseUser.providerData.first.providerId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final firebaseService = FirebaseService();
    await firebaseService.saveUser(newUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'NUTRIX',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () => _handleGoogleSignIn(context),
                  child: Image.asset(
                    'assets/images/google_icon.png',
                    width: 200,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
