import 'package:flutter/material.dart';
import '../CustomerOrder.dart'; // Import CustomerOrder.dart

class OrderDeclined extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to CustomerOrder.dart when the screen is tapped
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomerOrders()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon/Image
              Image.asset(
                'assets/DeclineOrderIcon/purplelogo.png', // Replace with your image path
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 16),
              // Text
              const Text(
                'Order Cancelled',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A0066), // Purple color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}