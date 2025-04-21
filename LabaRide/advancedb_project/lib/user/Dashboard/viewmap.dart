import 'package:flutter/material.dart';
import 'viewshopinfo.dart';

class MapScreen extends StatefulWidget {
  final int userId;
  final String token;

  const MapScreen({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> shops = [
    {
      'id': 'shop1',
      'name': 'Lavandera Ko',
      'image': 'assets/lavandera.png',
      'rating': 4.8,
      'reviewCount': '1.2k',
      'distance': '0.3 km',
      'location': 'Ellis Angeles St. Naga City',
      'status': 'Open',
      'businessHours': '8:00am - 5:00pm',
      'holidayHours': 'Time may vary',
      'shopId': '#123456ABCD',
      'services': ['Wash Only', 'Dry Clean', 'Steam Press', 'Full Service'],
      'position': const Offset(100, 200),
    },
    {
      'id': 'shop2',
      'name': 'Metropolitan Laundry',
      'image': 'assets/lavandera.png',
      'rating': 4.5,
      'reviewCount': '980',
      'distance': '0.5 km',
      'location': 'Peñafrancia Ave, Naga City',
      'status': 'Open',
      'businessHours': '7:00am - 6:00pm',
      'holidayHours': 'Time may vary',
      'shopId': '#789012EFGH',
      'services': ['Wash Only', 'Dry Clean', 'Steam Press'],
      'position': const Offset(200, 300),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Map Background
          _buildMapBackground(),
          
          // Shop Markers
          ..._buildShopMarkers(),
          
          // Current Location Button
          _buildLocationButton(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1A0066)),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.location_on,
                          color: Color(0xFF1A0066),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Type laundry shop name',
                            hintStyle: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                          onSubmitted: _handleSearch,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapBackground() {
    return Positioned.fill(
      child: Image.asset(
        'assets/mapa.png',
        fit: BoxFit.cover,
      ),
    );
  }

  List<Widget> _buildShopMarkers() {
    return shops.map((shop) => Positioned(
      top: shop['position'].dy,
      left: shop['position'].dx,
      child: GestureDetector(
        onTap: () => _showShopDetails(shop),
        child: Image.asset(
          'assets/laundryiconmap.png',
          width: 40,
          height: 40,
        ),
      ),
    )).toList();
  }

  Widget _buildLocationButton() {
    return Positioned(
      right: 16,
      bottom: 16,
      child: FloatingActionButton(
        onPressed: _handleLocationPress,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.my_location,
          color: Color(0xFF1A0066),
        ),
      ),
    );
  }

  void _handleSearch(String value) {
    // TODO: Implement search functionality
    print('Searching for: $value');
  }

  void _handleLocationPress() {
    // TODO: Implement current location functionality
    print('Getting current location');
  }

  void _showShopDetails(Map<String, dynamic> shop) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ShopDetailsOverlay(
        userId: widget.userId,
        token: widget.token,
        shopDetails: shop,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}