import 'package:flutter/material.dart';
import '../OrderScreen/OrderScreen.dart';
import '../authenticationadmin/loginscreen_admin.dart';
import 'Logout.dart';
import 'AccountInfo.dart';
import 'ShopDetails.dart';
import 'Security.dart';
import '../CustomerOrder/CustomerOrder.dart';
import '../DashboardAdmin/homescreen.dart';
import '../Services/ServiceScreen1.dart';

class ProfileScreenAdmin extends StatelessWidget {
  const ProfileScreenAdmin({super.key});

  final Color navyBlue = const Color(0xFF1A0066);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 90, 18, 103),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 20),
                // Profile Section 
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 90),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left side - Profile Title and Subtitle
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A0066),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Personalize your shop and\nPreferences',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.2,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            // Right side - Shop Details
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.4,
                                  ),
                                  child: Text(
                                    '#123456ABCD',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.4,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 14,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          'Elias Angeles St. Naga City',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '4.6',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[900],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.4,
                                  ),
                                  child: Text(
                                    'Business Hours: 8:00am - 5:00pm',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Menu Items Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    _buildMenuItem(
                      'Account Information',
                      'assets/ProfileScreen/Profile.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminAccountInfo(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      'Shop Details',
                      'assets/ProfileScreen/Shop.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopDetails(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      'Security',
                      'assets/ProfileScreen/Security.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Security(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      'Payment Method',
                      'assets/ProfileScreen/Payment.png',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      'Logout',
                      'assets/ProfileScreen/Logout.png',
                      isLogout: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => const LogoutDialog(),
                        ).then((confirmed) {
                          if (confirmed == true) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreenAdmin(),
                              ),
                              (route) => false,
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: 4,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: navyBlue,
    unselectedItemColor: Colors.grey,
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransactionsScreen(),
            ),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ServiceScreen1(),
            ),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomerOrders(),
            ),
          );
          break;
        case 4:
          //Already in Profile Screen
          break;
      }
    },
    items: [
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/OrderScreenIcon/Home.png',
          height: 24,
          color: Colors.grey,
        ),
        activeIcon: Image.asset(
          'assets/OrderScreenIcon/Home.png',
          height: 24,
          color: navyBlue,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/OrderScreenIcon/Orders.png',
          height: 24,
          color: Colors.grey,
        ),
        activeIcon: Image.asset(
          'assets/OrderScreenIcon/Orders.png',
          height: 24,
          color: navyBlue,
        ),
        label: 'Orders',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/OrderScreenIcon/Services.png',
          height: 24,
          color: Colors.grey,
        ),
        activeIcon: Image.asset(
          'assets/OrderScreenIcon/Services.png',
          height: 24,
          color: navyBlue,
        ),
        label: 'Services',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/OrderScreenIcon/Customers.png',
          height: 24,
          color: Colors.grey,
        ),
        activeIcon: Image.asset(
          'assets/OrderScreenIcon/Customers.png',
          height: 24,
          color: navyBlue,
        ),
        label: 'Customers',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          'assets/OrderScreenIcon/Profile.png',
          height: 24,
          color: Colors.grey,
        ),
        activeIcon: Image.asset(
          'assets/OrderScreenIcon/Profile.png',
          height: 24,
          color: navyBlue,
        ),
        label: 'Profile',
      ),
    ],
  );
}

  Widget _buildMenuItem(String title, String iconPath, {bool isLogout = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 24,
              color: isLogout ? Colors.red : navyBlue,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.red : Colors.black,
              ),
            ),
            const Spacer(),
            if (!isLogout)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }
}