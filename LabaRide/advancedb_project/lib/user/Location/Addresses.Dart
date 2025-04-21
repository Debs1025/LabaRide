import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../ProfileUser/ProfileScreen.dart';

class Addresses extends StatefulWidget {
  final int userId;
  final String token;

  const Addresses({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  final Color navyBlue = const Color(0xFF1A0066);
  
  final List<Map<String, String>> addresses = [
    {
      'title': 'Current Location',
      'address': 'Zone 3, San Jose California, USA',
    },
    {
      'title': 'Other Locations',
      'address': 'Ateneo De Naga',
    },
    {
      'title': '',
      'address': 'Universidad De Sta. Isabel',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: navyBlue),
          onPressed: () {
            Navigator.pushReplacement( // Changed to pushReplacement
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  userId: widget.userId, // Added required userId
                  token: widget.token,   // Added required token
                ),
              ),
            );
          },
        ),
        title: Text(
          'Addresses',
          style: TextStyle(
            color: navyBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              'assets/maps.png',
              height: 150,
              fit: BoxFit.contain,
            ),
          ),

          // Addresses List
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return _buildAddressItem(
                  title: addresses[index]['title'] ?? '',
                  address: addresses[index]['address'] ?? '',
                  isFirst: index == 0,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            _showAddAddressDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: navyBlue),
              SizedBox(width: 8),
              Text(
                'Use Current Location',
                style: TextStyle(
                  color: navyBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressItem({
    required String title,
    required String address,
    bool isFirst = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isFirst || title.isNotEmpty)
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ListTile(
          leading: Icon(
            Icons.location_on_outlined,
            color: navyBlue,
          ),
          title: Text(
            address,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showAddressOptions(address);
            },
          ),
        ),
        Divider(height: 1),
      ],
    );
  }

  void _showAddAddressDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Address',
          style: TextStyle(color: navyBlue),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter address',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: navyBlue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  addresses.add({
                    'title': '',
                    'address': controller.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: Text(
              'Add',
              style: TextStyle(color: navyBlue),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressOptions(String address) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: navyBlue),
              title: Text(
                'Edit',
                style: TextStyle(color: navyBlue),
              ),
              onTap: () {
                Navigator.pop(context);
                _showEditDialog(address);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                setState(() {
                  addresses.removeWhere((item) => item['address'] == address);
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(String oldAddress) {
    final TextEditingController controller = TextEditingController(text: oldAddress);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Address',
          style: TextStyle(color: navyBlue),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter new address',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: navyBlue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  int index = addresses.indexWhere((item) => item['address'] == oldAddress);
                  if (index != -1) {
                    addresses[index]['address'] = controller.text;
                  }
                });
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: navyBlue),
            ),
          ),
        ],
      ),
    );
  }
}