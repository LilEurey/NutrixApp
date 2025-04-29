import 'package:flutter/material.dart';
import 'package:frontend/screens/account.dart'; // import your AccountScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const Color mintGreen = Color(0xFFB9F3E3);
  static const Color darkTeal = Color(0xFF004D40);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _gender = 'Male';
  String _age = '20';
  String _weight = '62';
  String _height = '175';

  // Static About Nutrix text
  final String _aboutText =
      'Nutrix helps you track your meals, calculate calories, and achieve your goals effortlessly.';

  Future<void> _editField({
    required String title,
    required String initialValue,
    required ValueChanged<String> onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) async {
    String temp = initialValue;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextFormField(
          initialValue: temp,
          keyboardType: keyboardType,
          decoration: InputDecoration(hintText: title),
          onChanged: (v) => temp = v,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ProfileScreen.darkTeal,
            ),
            onPressed: () {
              setState(() => onSaved(temp));
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tappable header card (Drive)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AccountScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ProfileScreen.mintGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage('assets/images/avatar.png'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Drive',
                                style: TextStyle(
                                  color: ProfileScreen.darkTeal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
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

                    // Static Gender field
                    ProfileListItem(
                      icon: Icons.people,
                      label: 'Gender',
                      value: _gender,
                    ),

                    // Editable fields
                    ProfileListItem(
                      icon: Icons.cake,
                      label: 'Age',
                      value: '$_age years',
                      onTap: () => _editField(
                        title: 'Age',
                        initialValue: _age,
                        keyboardType: TextInputType.number,
                        onSaved: (v) => _age = v,
                      ),
                    ),
                    ProfileListItem(
                      icon: Icons.fitness_center,
                      label: 'Weight',
                      value: '$_weight kg',
                      onTap: () => _editField(
                        title: 'Weight (kg)',
                        initialValue: _weight,
                        keyboardType: TextInputType.number,
                        onSaved: (v) => _weight = v,
                      ),
                    ),
                    ProfileListItem(
                      icon: Icons.height,
                      label: 'Height',
                      value: '$_height cm',
                      onTap: () => _editField(
                        title: 'Height (cm)',
                        initialValue: _height,
                        keyboardType: TextInputType.number,
                        onSaved: (v) => _height = v,
                      ),
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

                    // About Nutrix: static text dialog
                    ProfileListItem(
                      icon: Icons.info,
                      label: 'About Nutrix',
                      value: 'Tap to view',
                      showArrow: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('About Nutrix'),
                            content: Text(_aboutText),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // Static App Version
                    ProfileListItem(
                      icon: Icons.apps,
                      label: 'App Version',
                      value: '1.0.0',
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Close button
            Positioned(
              bottom: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ProfileScreen.darkTeal, width: 2),
                    color: Colors.white,
                  ),
                  child: Icon(Icons.close, color: ProfileScreen.darkTeal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showArrow;
  final VoidCallback? onTap;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ProfileScreen.darkTeal),
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty) Text(value, style: TextStyle(color: Colors.grey[600])),
          if (showArrow || onTap != null) const SizedBox(width: 8),
          if (showArrow || onTap != null) Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
}
