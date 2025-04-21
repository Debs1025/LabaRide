import 'package:flutter/material.dart';
import '2PlaceOrder.dart';
import 'LaundryCount.dart';

class OrderConfirmScreen extends StatefulWidget {
  final int userId;
  final String token;

  const OrderConfirmScreen({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  _OrderConfirmScreenState createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  final TextEditingController noteController = TextEditingController();
  final Color navyBlue = const Color(0xFF1A0066);
  Map<String, int> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A0066)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Your Order',
          style: TextStyle(
            color: navyBlue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Order Details Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/basket.png',
                            height: 24,
                            color: navyBlue,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Your Order',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '165.00',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: navyBlue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.edit, size: 20, color: navyBlue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Laundries Card
              Card(
                margin: const EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/washingmachine.png',
                                height: 24,
                                color: navyBlue,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Laundries',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: navyBlue,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: navyBlue),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditLaundriesScreen(),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  selectedItems = result;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      if (selectedItems.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: selectedItems.entries
                              .where((entry) => entry.value > 0)
                              .map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  Text(
                                    '${entry.value}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: navyBlue,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),

              // Note Card
              Card(
                margin: const EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note to Laundry Shop',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: navyBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: noteController,
                        decoration: InputDecoration(
                          hintText: 'Add your note here',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Total Section
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          '₱ 165.00',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: navyBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Fee',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          '₱ 30.00',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: navyBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Voucher',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          '-₱10.00',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: navyBlue,
                          ),
                        ),
                        Text(
                          '₱ 185.00',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: navyBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  userId: widget.userId,
                  token: widget.token,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: navyBlue,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Proceed to checkout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}