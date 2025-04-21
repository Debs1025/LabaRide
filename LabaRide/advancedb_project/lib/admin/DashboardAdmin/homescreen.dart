import 'package:flutter/material.dart';
import '../OrderScreen/OrderScreen.dart';
import '../Services/ServiceScreen1.dart';
import '../ProfileAdmin/ProfileScreen.dart'; 
import '../CustomerOrder/CustomerOrder.dart';
import 'notifpage.dart'; // Import the NotificationsScreen
import 'rating.dart'; // Import the CustomerRatingsScreen

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 91, 50, 215),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0066),
        elevation: 0,
        title: const Text(
          'DASHBOARD',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/adminIcon/bell.png'),
            onPressed: () {
              // Navigate to the NotificationsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Orders Today Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TOTAL ORDERS TODAY',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A0066),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Customer Satisfaction Section
              GestureDetector(
                onTap: () {
                  // Navigate to the CustomerRatingsScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerRatingsScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CUSTOMER SATISFACTION',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A0066),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildSatisfactionItem(
                            'assets/adminIcon/happyface.png',
                            '90%',
                            'Satisfied',
                          ),
                          const SizedBox(width: 24),
                          _buildSatisfactionItem(
                            'assets/adminIcon/neutralface.png',
                            '2.8%',
                            'Neutral',
                          ),
                          const SizedBox(width: 24),
                          _buildSatisfactionItem(
                            'assets/adminIcon/sadface.png',
                            '8.2%',
                            'Unsatisfied',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Response received: 3,123',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Recent Transactions Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RECENT TRANSACTION',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A0066),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Recipient Name')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Service')),
                          DataColumn(label: Text('Delivery Type')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Total')),
                        ],
                        rows: [
                          _buildDataRow(
                            'Erick De Belen',
                            '03/29/2025',
                            'Full Service',
                            'Delivery',
                            'Pending',
                            '₱278',
                          ),
                          _buildDataRow(
                            'Nathaniel Delfino',
                            '03/28/2025',
                            'Full Service',
                            'Delivery',
                            'Out for Delivery',
                            '₱159',
                          ),
                          _buildDataRow(
                            'Ashley Vinzon',
                            '03/27/2025',
                            'Full Service',
                            'Pick Up',
                            'Delivered',
                            '₱304',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1A0066),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionsScreen(),
              ),
            );
          }
          if (index == 2) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ServiceScreen1(),
              ),
            );
          }
         if (index == 3) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerOrders(),
              ),
            );
          }
         if (index == 4) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenAdmin(),
              ),
            );
          }
        },
        
        
        items: [
          _buildNavItem('Home', 'assets/OrderScreenIcon/Home.png'),
          _buildNavItem('Orders', 'assets/OrderScreenIcon/Orders.png'),
          _buildNavItem('Services', 'assets/adminIcon/servicesicon.png'),
          _buildNavItem('Customers', 'assets/OrderScreenIcon/Customers.png'),
          _buildNavItem('Profile', 'assets/OrderScreenIcon/Profile.png'),
        ],
      ),
    );
  }

  Widget _buildSatisfactionItem(
    String iconPath,
    String percentage,
    String label,
  ) {
    return Column(
      children: [
        Image.asset(iconPath, height: 24),
        const SizedBox(height: 8),
        Text(
          percentage,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A0066),
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  DataRow _buildDataRow(
    String name,
    String date,
    String service,
    String deliveryType,
    String status,
    String total,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(date)),
        DataCell(Text(service)),
        DataCell(Text(deliveryType)),
        DataCell(_buildStatusChip(status)),
        DataCell(Text(total)),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.red.withOpacity(0.2);
        break;
      case 'out for delivery':
        backgroundColor = Colors.amber.withOpacity(0.2);
        break;
      case 'delivered':
        backgroundColor = Colors.green.withOpacity(0.2);
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.2);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(color: backgroundColor.withOpacity(1), fontSize: 14),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, String iconPath) {
    return BottomNavigationBarItem(
      icon: Image.asset(iconPath, height: 24, color: Colors.grey),
      activeIcon: Image.asset(
        iconPath,
        height: 24,
        color: const Color(0xFF1A0066),
      ),
      label: label,
    );
  }
}