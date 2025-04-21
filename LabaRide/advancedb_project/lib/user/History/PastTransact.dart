import 'package:flutter/material.dart';
import 'ActiveTransact.dart';
import 'DetailTransact.dart';
import '../ProfileUser/ProfileScreen.dart';

class PastTransact extends StatefulWidget {
  final int userId;
  final String token;

  const PastTransact({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  State<PastTransact> createState() => _PastTransactState();
}

class _PastTransactState extends State<PastTransact> {
  String calculateTotal(String serviceAmount, String deliveryFee) {
    double subtotalValue = double.parse(serviceAmount.replaceAll('P', ''));
    double shippingValue = deliveryFee == 'Free' ? 0 : double.parse(deliveryFee.replaceAll('P', ''));
    double discount = 10.00;
    
    double total = subtotalValue + shippingValue - discount;
    return 'P${total.toStringAsFixed(2)}';
  }

  final List<Map<String, dynamic>> dummyOrders = [
    {
      'date': 'Placed on Fri, 12 June 2025, 10:00 AM',
      'orderId': '1234567891',
      'location': 'Eleccion, Naga City, 4400, PH',
      'serviceAmount': 'P165.00',
      'deliveryFee': 'P99.00',
      'status': 'Complete Delivered',
    },
    {
      'orderId': '8765432190',
      'location': 'Canaman, Camarines Sur, 4402, PH',
      'serviceAmount': 'P165.00',
      'deliveryFee': 'Free',
      'status': 'Complete Delivered',
    },
    {
      'orderId': '12345678',
      'location': 'Legazpi City, 4500, PH',
      'serviceAmount': 'P165.00',
      'deliveryFee': 'P50.00',
      'status': 'Complete Delivered',
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
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A0066)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userId: widget.userId,
                token: widget.token,
              ),
            ),
          ),
        ),
        title: const Text(
          'History',
          style: TextStyle(
            color: Color(0xFF1A0066),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Custom Tab Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActiveTransact(
                          userId: widget.userId,
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'Active Order',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 2,
                        width: 100,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  children: const [
                    Text(
                      'Past Order',
                      style: TextStyle(
                        color: Color(0xFF375DFB),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 2,
                      width: 100,
                      child: ColoredBox(color: Color(0xFF375DFB)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: dummyOrders.map((order) {
                    String total = calculateTotal(
                      order['serviceAmount'] ?? 'P165.00',
                      order['deliveryFee'] ?? 'P50.00'
                    );
                    return _buildOrderCard(
                      context,
                      date: order['date'],
                      orderId: order['orderId'],
                      location: order['location'],
                      amount: total,
                      deliveryFee: order['deliveryFee'],
                      status: order['status'],
                      serviceAmount: order['serviceAmount'] ?? 'P165.00',
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    String? date,
    required String orderId,
    required String location,
    required String amount,
    required String deliveryFee,
    required String status,
    required String serviceAmount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (date != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Order ID: $orderId',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount Paid',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          amount,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Charges',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          deliveryFee,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailTransact(
                              orderDetails: {
                                'date': date,
                                'orderId': orderId,
                                'location': location,
                                'amount': amount,
                                'deliveryFee': deliveryFee,
                                'status': status,
                                'labaRiderId': 'PH2314325224J',
                                'customerName': 'Erick Nathaniel S. De Belen (+63) 847 713 3058',
                                'paymentMethod': 'GCash',
                                'serviceAmount': serviceAmount,
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF375DFB),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}