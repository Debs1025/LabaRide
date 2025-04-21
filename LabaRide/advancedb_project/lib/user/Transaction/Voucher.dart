import 'package:flutter/material.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0066),
        title: const Text(
          'Your Vouchers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFF003366), // Background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildVoucherCard(
                title: '- ₱150',
                subtitle: 'April 4 - 7, 2025',
                color: Colors.blue,
                giftAsset: 'assets/bluegift.png',
              ),
              const SizedBox(height: 20),
              _buildVoucherCard(
                title: '50% OFF',
                subtitle: 'April 4 - 10, 2025',
                color: Colors.pink,
                giftAsset: 'assets/pinkgift.png',
              ),
              const SizedBox(height: 20),
              _buildVoucherCard(
                title: '35% Shipping',
                subtitle: 'April 4, 2025',
                color: Colors.yellow,
                giftAsset: 'assets/yellowgift.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherCard({
    required String title,
    required String subtitle,
    required Color color,
    required String giftAsset,
  }) {
    return Stack(
      children: [
        // Main card
        Container(
          height: 120, // Increased height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Slightly larger radius
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Increased padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/Time.png', height: 20), // Larger time icon
                        const SizedBox(width: 10),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 14, // Slightly larger font size
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24, // Larger title font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Image.asset(giftAsset, height: 50), // Larger gift icon
              ],
            ),
          ),
        ),
        // Left cutout
        Positioned(
          left: -10, // Slightly outside the card
          top: 0,
          bottom: 0,
          child: Container(
            width: 20, // Larger cutout
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF003366),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF003366),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right cutout
        Positioned(
          right: -10, // Slightly outside the card
          top: 0,
          bottom: 0,
          child: Container(
            width: 20, // Larger cutout
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF003366),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFF003366),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}