import 'package:flutter/material.dart';
import 'EditProfile.dart';
import '../Location/Addresses.dart';
import '../authenticationuser/loginscreen_user.dart';
import '../History/ActiveTransact.dart';
import '../Dashboard/laundry_dashboard_screen.dart';
import '../Dashboard/search_screen.dart';
import '../Dashboard/activities_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final int userId;
  final String token;
  final Color navyBlue = const Color(0xFF000080);

  const ProfileScreen({
    super.key, 
    required this.userId,
    required this.token,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color navyBlue = const Color(0xFF000080);
  bool _isLoading = true;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/user/${widget.userId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['user'] != null) {
          setState(() {
            userData = data['user'];
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          // Profile Header
          Container(
            color: navyBlue,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/profile.png', width: 35),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['name'] ?? 'No Name',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '#${userData['id'] ?? ''}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          userId: widget.userId,
                          token: widget.token,
                          userData: userData,
                        ),
                      ),
                    ).then((updated) {
                      if (updated == true) {
                        _fetchUserData();
                      }
                    });
                  },
                  child: Image.asset(
                    'assets/edit.png',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Personal Details Section
          Expanded(
            child: Container(
              color: const Color(0xFFF5F7F9),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        'Personal Details',
                        style: TextStyle(
                          color: navyBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _buildDetailItem('assets/locationblue.png', 
                        '${userData['zone'] ?? ''}, ${userData['street'] ?? ''}, ${userData['barangay'] ?? ''}'),
                    _buildDetailItem('assets/contact.png', userData['phone'] ?? 'No phone'),
                    _buildDetailItem('assets/mail.png', userData['email'] ?? 'No email'),
                    _buildDetailItem('assets/birthdate.png', userData['birthdate']?.toString() ?? 'No birthdate'),
                    _buildDetailItem('assets/gender.png', userData['gender'] ?? 'No gender'),
                    
                    // Action Buttons
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildActionButton(
                            context, 
                            'Addresses', 
                            'assets/locationwhite.png',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Addresses(
                                  userId: widget.userId,
                                  token: widget.token,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildActionButton(
                            context, 
                            'Transactions', 
                            'assets/transaction.png',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActiveTransact(
                                  userId: widget.userId,
                                  token: widget.token,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Logout Button
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 17, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    'Do you want to logout?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  ],
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.red[50],
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 17, 0),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', Colors.grey, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LaundryDashboardScreen(
                    userId: widget.userId,
                    token: widget.token,
                  ),
                ),
              );
            }),
            _buildNavItem(Icons.search, 'Search', Colors.grey, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    userId: widget.userId,
                    token: widget.token,
                  ),
                ),
              );
            }),
            _buildNavItem(Icons.history, 'Activities', Colors.grey, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivitiesScreen(
                    userId: widget.userId,
                    token: widget.token,
                  ),
                ),
              );
            }),
            _buildNavItem(Icons.person, 'Profile', const Color(0xFF375DFB), null),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontFamily: 'Inter',
              fontWeight: color == const Color(0xFF375DFB) ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 16,
            height: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String text, String iconPath, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: navyBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}