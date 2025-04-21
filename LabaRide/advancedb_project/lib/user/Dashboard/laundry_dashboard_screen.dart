import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search_screen.dart';
import 'activities_screen.dart';
import 'notifications_screen.dart';
import '../ProfileUser/ProfileScreen.dart';
import '../OrderingSystem/ordershopsystem.dart';
import 'viewmap.dart';

class LaundryShop {
  final String name;
  final String image;
  final double rating;
  final String distance;
  final bool isOpen;
  final String location;
  final String status;
  final String totalPrice;

  LaundryShop({
    required this.name,
    required this.image,
    required this.rating,
    required this.distance,
    required this.isOpen,
    required this.location,
    required this.status,
    required this.totalPrice,
  });
}

class LaundryDashboardScreen extends StatefulWidget {
  final int userId;
  final String token;

  const LaundryDashboardScreen({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  State<LaundryDashboardScreen> createState() => _LaundryDashboardScreenState();
}

class _LaundryDashboardScreenState extends State<LaundryDashboardScreen> {
  Map<String, dynamic> userData = {};
  bool _isLoading = true;
  String _errorMessage = '';
  List<LaundryShop> recentShops = [];
  List<LaundryShop> nearbyShops = [];
  List<LaundryShop> topShops = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      await Future.wait([
        _fetchUserData(),
        _fetchShopData(),
      ]);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error initializing data: $e';
        _isLoading = false;
      });
    }
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
          });
        } else {
          throw Exception('User data is empty');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error loading user data: $e');
    }
  }

  Future<void> _fetchShopData() async {
    try {
      recentShops = [
        LaundryShop(
          name: 'Lavandera Ko',
          image: 'assets/lavandera.png',
          rating: 4.8,
          distance: '0.3 km',
          isOpen: true,
          location: 'Ellis Angeles St. Naga City',
          status: 'Open',
          totalPrice: '₱165.00',
        ),
      ];

      nearbyShops = [
        LaundryShop(
          name: 'WashMatic',
          image: 'assets/lavandera.png',
          rating: 4.5,
          distance: '0.5 km',
          isOpen: true,
          location: 'Zone 4, San Jose, Naga City',
          status: 'Open',
          totalPrice: '₱250.00',
        ),
      ];

      topShops = [
        LaundryShop(
          name: 'Metropolitan Laundry',
          image: 'assets/lavandera.png',
          rating: 4.9,
          distance: '1.2 km',
          isOpen: true,
          location: 'Peñafrancia Ave, Naga City',
          status: 'Open',
          totalPrice: '₱165.00',
        ),
      ];

      setState(() {});
    } catch (e) {
      throw Exception('Error loading shop data: $e');
    }
  }

  void _navigateToShop(LaundryShop shop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderShopSystem(
          userId: widget.userId,
          token: widget.token,
        ),
      ),
    );
  }

  void _navigateToMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          userId: widget.userId,
          token: widget.token,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${userData['zone'] ?? ''}, ${userData['street'] ?? ''}, ${userData['barangay'] ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(
                userId: widget.userId,
                token: widget.token,
              ),
            ),
          );
        },
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Search for laundry shop',
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: _navigateToMap,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    'View Map',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShopListView(List<LaundryShop> shops) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: shops.length,
        itemBuilder: (context, index) {
          final shop = shops[index];
          return GestureDetector(
            onTap: () => _navigateToShop(shop),
            child: Container(
              width: 180,
              margin: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == shops.length - 1 ? 16 : 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      shop.image,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              shop.rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              shop.distance,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.search, 'Search', false, () {
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
          _buildNavItem(Icons.history, 'Activities', false, () {
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
          _buildNavItem(Icons.person, 'Profile', false, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  userId: widget.userId,
                  token: widget.token,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF375DFB) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF375DFB) : Colors.grey,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWithViewAll(String title, List<LaundryShop> shops) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement view all functionality
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildShopListView(shops),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A0066)),
          ),
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _initializeData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A0066),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 30, 84, 171),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _initializeData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 16),
                        _buildSearchBar(context),
                        const SizedBox(height: 16),
                        _buildSectionTitle('Explore Laundry Shop'),
                        const SizedBox(height: 8),
                        _buildImageContainer('assets/maps.png', context),
                        const SizedBox(height: 16),
                        _buildSectionWithViewAll('Recent Laundry Shops', recentShops),
                        const SizedBox(height: 16),
                        _buildSectionWithViewAll('Nearby Laundry Shops', nearbyShops),
                        const SizedBox(height: 16),
                        _buildSectionWithViewAll('Top Laundry Shops', topShops),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomNavigationBar(context),
            ],
          ),
        ),
      ),
    );
  }
}