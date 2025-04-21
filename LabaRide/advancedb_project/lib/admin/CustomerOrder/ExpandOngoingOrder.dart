import 'package:flutter/material.dart';
import '../OrderScreen/OrderScreen.dart';
import '../ProfileAdmin/ProfileScreen.dart';
import 'CustomerOrder.dart';
import 'OngoingDetails.dart';

class ExpandOngoingOrder extends StatefulWidget {
  const ExpandOngoingOrder({super.key});

  @override
  State<ExpandOngoingOrder> createState() => _ExpandOngoingOrderState();
}

class _ExpandOngoingOrderState extends State<ExpandOngoingOrder> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> ongoingOrders = [
    {
      'orderId': '#HDJ9028',
      'user': 'Axel Salvador J',
      'service': 'Steam Press',
      'address': 'Naga City...',
      'date': '1 hours ago',
      'status': 'In Progress',
    },
    {
      'orderId': '#QJK7583',
      'user': 'Davon Segui',
      'service': 'Dry Clean',
      'address': 'St. Vincent',
      'date': '4 hours ago',
      'status': 'In Progress',
    },
  ];

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerOrders(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Customer Orders',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Ongoing Orders',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, String> order) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OngoingDetails(
                orderDetails: order,
              ),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['orderId']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo[900],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order['status']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink[400],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildOrderField('User', order['user']!),
                _buildOrderField('Service', order['service']!),
                _buildOrderField('Address', order['address']!),
                _buildOrderField('Date', order['date']!),
              ],
            ),
          ),
        ),
      );
    }

  Widget _buildOrderField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF48006A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: ongoingOrders.length,
                  itemBuilder: (context, index) => _buildOrderCard(ongoingOrders[index]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 3,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1A0066),
      onTap: (index) {
        switch (index) {
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionsScreen(),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenAdmin(),
              ),
            );
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/ProfileScreen/Home.png',
            height: 24,
            color: Colors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/ProfileScreen/Orders.png',
            height: 24,
            color: Colors.grey,
          ),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/ProfileScreen/Services.png',
            height: 24,
            color: Colors.grey,
          ),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/ProfileScreen/Customers.png',
            height: 24,
            color: const Color(0xFF1A0066),
          ),
          label: 'Customers',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/ProfileScreen/Profile.png',
            height: 24,
            color: Colors.grey,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}