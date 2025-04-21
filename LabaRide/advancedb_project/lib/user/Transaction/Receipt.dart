import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  final Color navyBlue = const Color(0xFF1A0066);

  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Receipt Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Zone 6, Sta. Cruz, Naga City, 4400, PH',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Bill Details'),
            _buildBillItem('Shirt (3 pcs)', '₱45.00'),
            _buildBillItem('T-shirt (4 pcs)', '₱90.00'),
            _buildBillItem('Shorts (3 pcs)', '₱60.00'),
            const Divider(height: 32),
            _buildBillItem('Delivery Fee', '₱49.00'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promo Code',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text('SRCJX123Q5', style: TextStyle(color: navyBlue)),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '₱244.00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Payment Method'),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset('assets/gcash.png', height: 24),
                const SizedBox(width: 24),
                Image.asset('assets/emoney.png', height: 24),
              ],
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                // Handle download receipt
              },
              child: Text(
                'Download receipt',
                style: TextStyle(
                  color: navyBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBillItem(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[700]),
          ),
          Text(amount),
        ],
      ),
    );
  }
}