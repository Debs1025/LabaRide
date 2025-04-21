import 'package:flutter/material.dart';
import '../OrderScreen/OrderScreen.dart';
import '../ProfileAdmin/ProfileScreen.dart';
import 'CustomerOrder.dart';
import 'AcceptingOrder.dart';

class ExpandNewOrder extends StatefulWidget {
  const ExpandNewOrder({super.key});

  @override
  State<ExpandNewOrder> createState() => _ExpandNewOrderState();
}

class _ExpandNewOrderState extends State<ExpandNewOrder> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> newOrders = [
    {
      'orderId': '#CON128',
      'user': 'Carl Valenciano',
      'service': 'Wash Only',
      'address': 'Naga City...',
      'date': 'Just Now',
      'time': '9 mins',
      'subtotal': '178',
      'deliveryFee': '50',
      'total': '228',
      'clothes': [
        {'item': 'Shirts', 'quantity': '5', 'price': '50'},
        {'item': 'Pants', 'quantity': '3', 'price': '36'},
        {'item': 'Uniforms', 'quantity': '1', 'price': '12'},
      ].toString(),
      'household': [
        {'item': 'Blankets', 'quantity': '2', 'price': '30'},
        {'item': 'Pillowcases', 'quantity': '5', 'price': '50'},
      ].toString(),
    },
    {
      'orderId': '#OST9374',
      'user': 'Eric Nathaniel D.',
      'service': 'Dry Clean',
      'address': 'St. Vincent',
      'date': '4mins',
      'time': '15 mins',
      'subtotal': '200',
      'deliveryFee': '50',
      'total': '250',
      'clothes': [
        {'item': 'Shirts', 'quantity': '4', 'price': '100'},
        {'item': 'Pants', 'quantity': '2', 'price': '100'},
      ].toString(),
      'household': '[]',
    },
    {
      'orderId': '#BRY92034',
      'user': 'Ashley Vinzon',
      'service': 'Steam Press',
      'address': 'Concepcion Pequeña',
      'date': '15mins',
      'time': '20 mins',
      'subtotal': '150',
      'deliveryFee': '50',
      'total': '200',
      'clothes': [
        {'item': 'Formal Wear', 'quantity': '3', 'price': '150'},
      ].toString(),
      'household': '[]',
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
              'New Orders',
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
            builder: (context) => AcceptingOrder(
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
              Text(
                order['orderId']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo[900],
                ),
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
                  itemCount: newOrders.length,
                  itemBuilder: (context, index) => _buildOrderCard(newOrders[index]),
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