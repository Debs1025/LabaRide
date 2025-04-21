import 'package:flutter/material.dart';
import '3ProceedOrder.dart';
import 'Voucher.dart';
import '../Location/AddLocation.dart';

class CheckoutScreen extends StatefulWidget {
  final int userId;
  final String token;

  const CheckoutScreen({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Color navyBlue = const Color(0xFF1A0066);
  String? preferredDeliveryTime;
  String? preferredDeliveryDate;
  bool isLoading = false;
  String? deliveryAddress;
  String? addressError;

  // Order details
  final double subtotal = 165.00;
  final double deliveryFee = 30.00;
  final double voucherDiscount = 10.00;
  double get total => subtotal + deliveryFee - voucherDiscount;

  @override
  void initState() {
    super.initState();
    deliveryAddress = 'Home\nZone 4, San Jose, Barangay California USA\nBuilding Name: Orange Dormitel';
  }

  Future<void> _updateDeliveryAddress() async {
  try {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddLocation(
          userId: widget.userId,  
          token: widget.token,  
        ),
      ),
    );

    if (result != null) {
      setState(() {
        deliveryAddress = result;
        addressError = null;
      });
    }
  } catch (e) {
    setState(() {
      addressError = 'Failed to update address';
    });
  }
}

  Widget _buildLocationCard() {
    return Card(
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
                    Icon(Icons.location_on, color: navyBlue),
                    const SizedBox(width: 12),
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: navyBlue,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: _updateDeliveryAddress,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (deliveryAddress != null)
              Text(
                deliveryAddress!,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            if (addressError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  addressError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Card(
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
                    Icon(Icons.receipt, color: navyBlue),
                    const SizedBox(width: 12),
                    Text(
                      'Order Summary',
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
                  onPressed: () {
                    // TODO: Implement edit order summary
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Wash Only',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: navyBlue,
              ),
            ),
            const SizedBox(height: 8),
            _buildPriceRow('Subtotal', subtotal),
            _buildPriceRow('Delivery Fee', deliveryFee),
            _buildPriceRow('Voucher', -voucherDiscount, isDiscount: true),
            const Divider(height: 24),
            _buildPriceRow('Total (incl. vat)', total, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? navyBlue : Colors.grey[600],
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            isDiscount ? '-₱${amount.toStringAsFixed(2)}' : '₱${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDiscount ? Colors.green : (isTotal ? navyBlue : navyBlue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.payment, color: navyBlue),
                const SizedBox(width: 12),
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: navyBlue,
                  ),
                ),
              ],
            ),
            Text(
              'See all',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: navyBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryScheduleCard() {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_shipping, color: navyBlue),
                    const SizedBox(width: 8),
                    Text(
                      'Delivery Schedule',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: navyBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Timestamp:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: navyBlue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      preferredDeliveryTime ?? '--:--',
                      style: TextStyle(
                        fontSize: 14,
                        color: preferredDeliveryTime == null ? Colors.grey : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      preferredDeliveryDate ?? '--/--/--',
                      style: TextStyle(
                        fontSize: 14,
                        color: preferredDeliveryDate == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.edit, size: 20, color: navyBlue),
              onPressed: () => _showDeliveryScheduleModal(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherCard() {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.local_offer, color: navyBlue),
                const SizedBox(width: 12),
                Text(
                  'Voucher',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: navyBlue,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.edit, size: 20, color: navyBlue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VoucherScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _placeOrder() async {
    if (!_validateOrder()) return;

    setState(() => isLoading = true);

    try {
      // Add your API call here to place the order
      await Future.delayed(const Duration(seconds: 1)); // Simulated API delay

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderCompleteScreen(
              userId: widget.userId,
              token: widget.token,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to place order: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  bool _validateOrder() {
    bool isValid = true;

    if (deliveryAddress == null || deliveryAddress!.isEmpty) {
      setState(() => addressError = 'Please add delivery address');
      isValid = false;
    }

    if (preferredDeliveryTime == null || preferredDeliveryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select delivery schedule'),
          backgroundColor: Colors.red,
        ),
      );
      isValid = false;
    }

    return isValid;
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                '₱${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: navyBlue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '(incl. vat)',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: isLoading ? null : _placeOrder,
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
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

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
          'Checkout',
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
              _buildLocationCard(),
              _buildOrderSummaryCard(),
              _buildPaymentMethodCard(),
              _buildDeliveryScheduleCard(),
              _buildVoucherCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  void _showDeliveryScheduleModal(BuildContext context) {
    int selectedHour = 12;
    int selectedMinute = 0;
    String selectedPeriod = "PM";
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select delivery time and date',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: navyBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTimeSelectionRow(
                    selectedHour,
                    selectedMinute,
                    selectedPeriod,
                    setState,
                  ),
                  const SizedBox(height: 16),
                  _buildDateSelectionRow(selectedDate, setState),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _updateDeliverySchedule(
                        selectedHour,
                        selectedMinute,
                        selectedPeriod,
                        selectedDate,
                        context,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navyBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimeSelectionRow(
    int selectedHour,
    int selectedMinute,
    String selectedPeriod,
    StateSetter setState,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<int>(
          value: selectedHour,
          items: List.generate(12, (index) {
            return DropdownMenuItem(
              value: index + 1,
              child: Text((index + 1).toString().padLeft(2, '0')),
            );
          }),
          onChanged: (value) => setState(() => selectedHour = value!),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(':'),
        ),
        DropdownButton<int>(
          value: selectedMinute,
          items: List.generate(60, (index) {
            return DropdownMenuItem(
              value: index,
              child: Text(index.toString().padLeft(2, '0')),
            );
          }),
          onChanged: (value) => setState(() => selectedMinute = value!),
        ),
        const SizedBox(width: 16),
        DropdownButton<String>(
          value: selectedPeriod,
          items: const [
            DropdownMenuItem(value: "AM", child: Text("AM")),
            DropdownMenuItem(value: "PM", child: Text("PM")),
          ],
          onChanged: (value) => setState(() => selectedPeriod = value!),
        ),
      ],
    );
  }

  Widget _buildDateSelectionRow(DateTime selectedDate, StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Date:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        TextButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: navyBlue,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              setState(() => selectedDate = pickedDate);
            }
          },
          child: Text(
            "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year.toString().substring(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: navyBlue,
            ),
          ),
        ),
      ],
    );
  }

  void _updateDeliverySchedule(
    int selectedHour,
    int selectedMinute,
    String selectedPeriod,
    DateTime selectedDate,
    BuildContext context,
  ) {
    setState(() {
      preferredDeliveryTime =
          "${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod";
      preferredDeliveryDate =
          "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year.toString().substring(2)}";
    });
    Navigator.pop(context);
  }
}