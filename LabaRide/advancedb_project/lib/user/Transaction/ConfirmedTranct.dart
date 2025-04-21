import 'package:flutter/material.dart';
import 'CancelOrder.dart';
import 'OrderDelivered.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int userId;
  final String token;

  const OrderDetailsScreen({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final Color navyBlue = const Color(0xFF1A0066);
  bool isDetailsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/exit.png',
            height: 24,
            width: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderDeliveredScreen(),
              ),
            );
          },
          child: const Text(
            'Order Details', 
            style: TextStyle(
              color: Color(0xFF1A0066),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you for your order!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: navyBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hi user! We have received your order and we will notify you once it is ready to be delivered.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add status check logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: navyBlue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Check Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              _buildOrderDetails(),
              const SizedBox(height: 16),
              const Divider(),
              _buildViewDetailsSection(),
              const SizedBox(height: 16),
              const Divider(),
              _buildPaymentSection(),
              const SizedBox(height: 16),
              _buildCancelButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: navyBlue,
          ),
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Order number', 'ABMWE23213'),
        const SizedBox(height: 8),
        _buildDetailRow('Order from', 'Erick De Belen'),
        const SizedBox(height: 8),
        _buildDetailRow('Delivery address', '259 Naga City'),
        const SizedBox(height: 16),
        _buildDetailRow('Total (incl. VAT)', '₱ 185', isBold: true),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? navyBlue : Colors.grey[600],
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? navyBlue : null,
          ),
        ),
      ],
    );
  }

  Widget _buildViewDetailsSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDetailsExpanded = !isDetailsExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'View Details (1 Items)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: navyBlue,
                ),
              ),
              Icon(
                isDetailsExpanded ? Icons.expand_less : Icons.expand_more,
                color: navyBlue,
              ),
            ],
          ),
        ),
        if (isDetailsExpanded) ...[
          const SizedBox(height: 8),
          _buildDetailRow('Subtotal', '₱ 165.00'),
          const SizedBox(height: 8),
          _buildDetailRow('Delivery Fee', '₱ 30.00'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Voucher',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const Text(
                '-₱ 10.00',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Total', '₱ 185.00', isBold: true),
        ],
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Paid with:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: navyBlue,
          ),
        ),
        Text(
          'Gcash\n+00**12***567',
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildCancelButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmCancelScreen(
                userId: widget.userId,
                token: widget.token,
              ),
            ),
          );
        },
        child: const Text(
          'Cancel Order',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}