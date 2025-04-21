import 'package:flutter/material.dart';
import 'IndividualTransact.dart';
import '../ProfileAdmin/ProfileScreen.dart'; 
import '../CustomerOrder/CustomerOrder.dart';
import '../DashboardAdmin/homescreen.dart';
import '../Services/ServiceScreen1.dart';

class TransactionsScreen extends StatefulWidget {
   const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final Color navyBlue = const Color(0xFF1A0066);
  bool isItemSelected = false;
  final Map<String, bool> selectedItems = {};
  String selectedFilter = 'All';

  // Sample transaction data
  final List<Map<String, String>> transactionsData = [
    {
      'customerId': '#1234567891',
      'recipientName': 'Erick De Belen',
      'date': '03/29/2025',
      'service': 'Wash Only',
      'deliveryType': 'Delivery',
      'statusType': 'Pending',
      'paymentType': 'Cash on Delivery',
      'totalAmount': '₱278',
      'paymentStatus': 'Paid',
      'orderStatus': 'Completed',
    },
    {
      'customerId': '#1234567892',
      'recipientName': 'Nathaniel Delfino',
      'date': '03/28/2025',
      'service': 'Full Service',
      'deliveryType': 'Pick Up',
      'statusType': 'Pending',
      'paymentType': 'Cash on Delivery',
      'totalAmount': '₱159',
      'paymentStatus': 'Unpaid',
      'orderStatus': 'In Progress',
    },
    {
      'customerId': '#1234567893',
      'recipientName': 'Ashley Vinzon',
      'date': '03/27/2025',
      'service': 'Full Service',
      'deliveryType': 'Delivery',
      'statusType': 'Cancelled',
      'paymentType': 'Cash on Delivery',
      'totalAmount': '₱304',
      'paymentStatus': 'Unpaid',
      'orderStatus': 'Cancelled',
    },
  ];

  List<Map<String, String>> getFilteredTransactions() {
    if (selectedFilter == 'All') {
      return transactionsData;
    }
    return transactionsData.where((transaction) {
      return transaction['orderStatus']?.toLowerCase() == selectedFilter.toLowerCase();
    }).toList();
  }

  Future<void> deleteSelectedOrders() async {
    List<String> orderIdsToDelete = selectedItems.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (orderIdsToDelete.isEmpty) return;

    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${orderIdsToDelete.length} selected order(s)?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ) ?? false;

    if (confirmDelete) {
      setState(() {
        transactionsData.removeWhere(
          (transaction) => orderIdsToDelete.contains(transaction['customerId'])
        );
        selectedItems.clear();
        isItemSelected = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Orders deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: _buildDataTableSection(),
          ),
        ],
      ),
      bottomNavigationBar: isItemSelected 
          ? _buildSelectionActionBar()
          : _buildDefaultNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TRANSACTIONS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', 'assets/OrderScreenIcon/All.png'),
                const SizedBox(width: 8),
                _buildFilterChip('Cancelled', 'assets/OrderScreenIcon/Cancelled.png'),
                const SizedBox(width: 8),
                _buildFilterChip('In Progress', 'assets/OrderScreenIcon/Active.png'),
                const SizedBox(width: 8),
                _buildFilterChip('Completed', 'assets/OrderScreenIcon/Completed.png'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: Image.asset(
                'assets/OrderScreenIcon/Search.png',
                color: Colors.white.withOpacity(0.5),
                height: 20,
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTableSection() {
    final filteredData = getFilteredTransactions();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 20,
            columns: const [
              DataColumn(label: Text('')),
              DataColumn(label: Text('Customer ID')),
              DataColumn(label: Text('Recipient Name')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Service')),
              DataColumn(label: Text('Delivery Type')),
              DataColumn(label: Text('Status Type')),
              DataColumn(label: Text('Payment Type')),
              DataColumn(label: Text('Total Amount')),
              DataColumn(label: Text('Payment Status')),
              DataColumn(label: Text('Order Status')),
            ],
            rows: filteredData.map((data) => _buildDataRow(
              data['customerId']!,
              data['recipientName']!,
              data['date']!,
              data['service']!,
              data['deliveryType']!,
              data['statusType']!,
              data['paymentType']!,
              data['totalAmount']!,
              data['paymentStatus']!,
              data['orderStatus']!,
            )).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionActionBar() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedItems.clear();
                isItemSelected = false;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              'Back',
              style: TextStyle(
                color: Color(0xFF1A0066),
                fontSize: 18,
              ),
            ),
          ),
          TextButton(
            onPressed: deleteSelectedOrders,
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: navyBlue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0: // Add case for Customers
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
            break;
          case 2: // Add case for Customers
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ServiceScreen1(),
              ),
            );
            break;
          case 3: // Add case for Customers
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerOrders(),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenAdmin(),
              ),
            );
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
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
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
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/OrderScreenIcon/Customers.png',
            height: 24,
            color: Colors.grey,
          ),
          label: 'Customers',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/OrderScreenIcon/Profile.png',
            height: 24,
            color: Colors.grey,
          ),
          label: 'Profile',
        ),
      ],
    );
  }

Widget _buildFilterChip(String label, String iconPath) {
  final bool isSelected = selectedFilter == label;
  final bool isAll = label == 'All';
  final Color textAndIconColor = isAll ? navyBlue : (isSelected ? Colors.white : navyBlue);

  return FilterChip(
    selected: isSelected && !isAll,
    showCheckmark: !isAll,
    label: Row(
      children: [
        Image.asset(
          iconPath,
          height: 16,
          color: textAndIconColor,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: textAndIconColor,
          ),
        ),
      ],
    ),
    backgroundColor: isAll ? Colors.transparent : Colors.white,
    selectedColor: navyBlue,
    onSelected: (bool selected) {
      setState(() {
        selectedFilter = selected ? label : 'All';
      });
    },
  );
}

DataRow _buildDataRow(
  String customerId,
  String recipientName,
  String date,
  String service,
  String deliveryType,
  String statusType,
  String paymentType,
  String totalAmount,
  String paymentStatus,
  String orderStatus,
) {
  return DataRow(
    selected: selectedItems[customerId] ?? false,
    cells: [
      DataCell(
        Checkbox(
          value: selectedItems[customerId] ?? false,
          onChanged: (bool? value) {
            setState(() {
              selectedItems[customerId] = value ?? false;
              isItemSelected = selectedItems.values.contains(true);
            });
          },
          activeColor: navyBlue,
        ),
      ),
      
    ...[ 
        DataCell(Text(customerId)),
        DataCell(Text(recipientName)),
        DataCell(Text(date)),
        DataCell(_buildServiceChip(service)),
        DataCell(Text(deliveryType)),
        DataCell(_buildStatusChip(statusType)),
        DataCell(Text(paymentType)),
        DataCell(Text(totalAmount)),
        DataCell(_buildPaymentStatusText(paymentStatus)),
        DataCell(_buildOrderStatusChip(orderStatus)),
      ].map((cell) => DataCell(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndividualTransact(
                  transactionData: {
                    'customerId': customerId,
                    'recipientName': recipientName,
                    'date': date,
                    'service': service,
                    'deliveryType': deliveryType,
                    'statusType': statusType,
                    'paymentType': paymentType,
                    'totalAmount': totalAmount,
                    'paymentStatus': paymentStatus,
                    'orderStatus': orderStatus,
                  },
                ),
              ),
            );
          },
          child: cell.child,
        ),
      )),
    ],
  );
}

  Widget _buildServiceChip(String service) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(service),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange;
        break;
      case 'delivered':
        backgroundColor = Colors.green;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: TextStyle(color: backgroundColor),
      ),
    );
  }

  Widget _buildPaymentStatusText(String status) {
    return Text(
      status,
      style: TextStyle(
        color: status.toLowerCase() == 'paid' ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildOrderStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = Colors.green;
        textColor = Colors.green;
        break;
      case 'in progress':
        backgroundColor = Colors.blue;
        textColor = Colors.blue;
        break;
      case 'cancelled':
        backgroundColor = Colors.red;
        textColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.grey;
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: TextStyle(color: textColor),
      ),
    );
  }
}