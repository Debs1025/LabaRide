import 'package:flutter/material.dart';

class DetailTransact extends StatelessWidget {
  final Map<String, dynamic> orderDetails;

  const DetailTransact({
    super.key,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1A0066)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Full Details',
          style: TextStyle(
            color: Color(0xFF1A0066),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Card
                Container(
                  color: Color(0xFF1A0066),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Text(
                    orderDetails['status'] ?? 'Your Order is Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Shipping Information
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Information',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'LabaRider: ${orderDetails['labaRiderId'] ?? 'PH2314325224J'}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Image.asset(
                            'assets/delivery.png',
                            width: 24,
                            height: 24,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Laundry has been delivered',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                orderDetails['date'] ?? '5-12-2025 15:59',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Delivery Information
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Information',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            'assets/shop.png',
                            width: 24,
                            height: 24,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderDetails['customerName'] ?? 'Erick Nathaniel S. De Belen (+63) 847 713 3058',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  orderDetails['location'] ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Lavandera Ko Section
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lavandera Ko',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Image.asset(
                            'assets/washonly.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wash Only',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Standard laundering, folding.',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            orderDetails['serviceAmount'] ?? 'P165.00',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Order Summary
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildSummaryRow('Laundries Subtotal', orderDetails['serviceAmount'] ?? 'P165.00'),
                      SizedBox(height: 8),
                      _buildSummaryRow('Shipping Fee', orderDetails['deliveryFee'] ?? 'P50.00'),
                      SizedBox(height: 8),
                      _buildSummaryRow('Shipping Discount Subtotal', '-P10.00'),
                      Divider(height: 24),
                      _buildSummaryRow(
                        'Order Total:',
                        calculateTotal(),
                        isTotal: true,
                      ),
                    ],
                  ),
                ),

                // Order ID
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildSummaryRow('Order ID:', orderDetails['orderId'] ?? ''),
                      SizedBox(height: 8),
                      _buildSummaryRow('Paid by', orderDetails['paymentMethod'] ?? 'GCash'),
                    ],
                  ),
                ),
                
                SizedBox(height: 80),
              ],
            ),
          ),

          // Fixed Order Again Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement order again functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  elevation: 0,
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text(
                  'Order Again',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String calculateTotal() {
    String subtotal = orderDetails['serviceAmount'] ?? 'P165.00';
    String shippingFee = orderDetails['deliveryFee'] ?? 'P50.00';
    const double discount = 10.00;

   
    double subtotalValue = double.parse(subtotal.replaceAll('P', ''));
    double shippingValue = shippingFee == 'Free' ? 0 : double.parse(shippingFee.replaceAll('P', ''));
    
    // Calculate total: subtotal + shipping - discount
    double total = subtotalValue + shippingValue - discount;
    return 'P${total.toStringAsFixed(2)}';
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.black : Colors.grey[600],
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? Colors.black : Colors.grey[600],
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}