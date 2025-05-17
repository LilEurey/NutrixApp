import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const Color mintGreen = Color(0xFFB9F3E3);
  static const Color darkTeal = Color(0xFF004D40);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'User';
  String _gender = '-';
  String _age = '-';
  String _weight = '-';
  String _height = '-';
  String _profilePictureUrl = '';
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
        _username = data['username'] ?? _username;
        _gender = data['gender'] ?? _gender;
        _age = data['age_years']?.toString() ?? _age;
        _weight = data['weight_kg']?.toString() ?? _weight;
        _height = data['height_cm']?.toString() ?? _height;
        _profilePictureUrl = data['profile_picture_url'] ?? '';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:
                                  () =>
                                      Navigator.pushNamed(context, '/account'),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: ProfileScreen.mintGreen,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage:
                                          _profilePictureUrl.isNotEmpty
                                              ? NetworkImage(_profilePictureUrl)
                                              : const AssetImage(
                                                    'assets/images/avatar.png',
                                                  )
                                                  as ImageProvider,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _username,
                                        style: const TextStyle(
                                          color: ProfileScreen.darkTeal,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: ProfileScreen.darkTeal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(Icons.people, 'Gender', _gender),
                            _buildInfoRow(Icons.cake, 'Age', '$_age yrs'),
                            _buildInfoRow(
                              Icons.monitor_weight,
                              'Weight',
                              '$_weight kg',
                            ),
                            _buildInfoRow(
                              Icons.height,
                              'Height',
                              '$_height cm',
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'About Us',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildNavRow(
                              Icons.info_outline,
                              'About Nutrix',
                              '/about',
                            ),
                            _buildInfoRow(Icons.apps, 'App Version', '1.0.0'),
                            _buildNavRow(Icons.shield, 'Safety', '/safety'),
                            _buildNavRow(
                              Icons.privacy_tip,
                              'Privacy',
                              '/privacy',
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),

                    // ⬅️ Back + ⏹ Centered Logout at bottom
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap:
                                () =>
                                    Navigator.pushNamed(context, '/homescreen'),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: ProfileScreen.darkTeal,
                              ),
                            ),
                          ),

                          // Logout Button (centered visually)
                          ElevatedButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              if (!mounted) return;
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/authchoice',
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              'Log out',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ProfileScreen.darkTeal),
      title: Text(label),
      trailing: Text(value, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _buildNavRow(IconData icon, String label, String route) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ProfileScreen.darkTeal),
      title: Text(label),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
