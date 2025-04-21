import 'package:flutter/material.dart';
import 'PastTransact.dart';
import '../ProfileUser/ProfileScreen.dart';

class ActiveTransact extends StatefulWidget {
  final int userId;
  final String token;

  const ActiveTransact({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  State<ActiveTransact> createState() => _ActiveTransactState();
}

class _ActiveTransactState extends State<ActiveTransact> {
  final List<Map<String, String>> dummyOrders = [
    {
      'date': 'Today',
      'orderId': '#ABMWE23213',
      'location': 'Lavandera Ko - Zone 4, San Jose, Naga City',
      'amount': '₱165.00',
      'deliveryFee': '₱30.00',
      'status': 'Processing',
      'totalAmount': '₱195.00',
      'service': 'Wash Only',
    },
    {
      'date': 'Yesterday',
      'orderId': '#DEFTY45678',
      'location': 'Lavandera Ko - Concepcion Pequeña, Naga City',
      'amount': '₱250.00',
      'deliveryFee': '₱30.00',
      'status': 'In Progress',
      'totalAmount': '₱280.00',
      'service': 'Full Service',
    }
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
                Column(
                  children: [
                    const Text(
                      'Active Order',
                      style: TextStyle(
                        color: Color(0xFF375DFB),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 2,
                      width: 100,
                      color: const Color(0xFF375DFB),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PastTransact(
                          userId: widget.userId,
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'Past Order',
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
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: dummyOrders.isEmpty
                ? Center(
                    child: Text(
                      'No active orders',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: dummyOrders.map((order) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: _buildOrderCard(
                              date: order['date']!,
                              orderId: order['orderId']!,
                              location: order['location']!,
                              amount: order['amount']!,
                              deliveryFee: order['deliveryFee']!,
                              status: order['status']!,
                              service: order['service']!,
                            ),
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

  Widget _buildOrderCard({
    required String date,
    required String orderId,
    required String location,
    required String amount,
    required String deliveryFee,
    required String status,
    required String service,
  }) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: status == 'Processing'
                            ? Colors.orange[50]
                            : Colors.blue[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: status == 'Processing'
                              ? Colors.orange
                              : Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
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
                Text(
                  'Service: $service',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
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
                    ),
                    Expanded(
                      child: Column(
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
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to order details screen
                        // TODO: Implement navigation
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