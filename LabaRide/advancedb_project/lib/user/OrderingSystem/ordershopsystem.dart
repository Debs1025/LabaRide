import 'package:flutter/material.dart';
import './laundryfulldetails.dart';
import '../Transaction/1OrderConfirm.dart';

class Service {
  final String title;
  final String description;
  final double price;
  final Color color;
  bool isSelected;
  bool hasSteamPress;
  bool hasDryClean;
  bool hasWashOnly;

  Service({
    required this.title,
    required this.description,
    required this.price,
    required this.color,
    this.isSelected = false,
    this.hasSteamPress = false,
    this.hasDryClean = false,
    this.hasWashOnly = false,
  });

  double get totalPrice {
    double total = price;
    if (hasSteamPress) total += 95.00;
    if (hasDryClean) total += 80.00;
    if (hasWashOnly) total += 100.00;
    return total;
  }

  void resetAddOns() {
    hasSteamPress = false;
    hasDryClean = false;
    hasWashOnly = false;
  }
}

class OrderShopSystem extends StatefulWidget {
  final int userId;
  final String token;

  const OrderShopSystem({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  State<OrderShopSystem> createState() => _OrderShopSystemState();
}

class _OrderShopSystemState extends State<OrderShopSystem> {
  String deliveryOption = "Deliver";
  double totalPrice = 0.0;

  final List<Service> services = [
    Service(
      title: "WASH ONLY",
      description: "Fresh, clean, and hassle-free—our Wash-Only Laundry Service gives your clothes a deep, professional clean with premium detergents, so they're spotless, fresh-smelling, and ready for you to dry and fold your way!",
      price: 100.00,
      color: const Color.fromARGB(255, 158, 191, 215),
    ),
    Service(
      title: "STEAM PRESS",
      description: "Professional steam pressing service for wrinkle-free garments. Keep your clothes looking crisp and professional.",
      price: 95.00,
      color: const Color(0xFF90CAF9),
    ),
    Service(
      title: "DRY CLEAN",
      description: "Specialized dry cleaning for delicate fabrics. Perfect for suits, dresses, and sensitive materials.",
      price: 80.00, 
      color: const Color(0xFF7E57C2),
    ),
    Service(
      title: "FULL SERVICE",
      description: "Complete laundry service including wash, dry, and fold. The ultimate convenience for your laundry needs.",
      price: 165.00,
      color: const Color(0xFF1A237E),
    ),
  ];

  void _showDeliveryOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.delivery_dining,
                  color: Color(0xFF1A0066),
                ),
                title: const Text(
                  'Deliver',
                  style: TextStyle(
                    color: Color(0xFF1A0066),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  setState(() => deliveryOption = "Deliver");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.store,
                  color: Color(0xFF1A0066),
                ),
                title: const Text(
                  'Pickup',
                  style: TextStyle(
                    color: Color(0xFF1A0066),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  setState(() => deliveryOption = "Pickup");
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showServiceDetails(Service service) {
    bool hasSteamPress = service.hasSteamPress;
    bool hasDryClean = service.hasDryClean;
    bool hasWashOnly = service.hasWashOnly;
    double currentTotal = service.price;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            currentTotal = service.price;
            if (hasSteamPress) currentTotal += 95.00;
            if (hasDryClean) currentTotal += 80.00;
            if (hasWashOnly) currentTotal += 100.00;

            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(
                                  service.title == "WASH ONLY" 
                                    ? 'assets/washonly.png'
                                    : service.title == "STEAM PRESS" 
                                      ? 'assets/steampresspic.png'
                                      : service.title == "DRY CLEAN"
                                        ? 'assets/drycleanpic.png'
                                        : 'assets/washonly.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            service.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Image.asset('assets/peso.png', height: 16),
                              Text(
                                " ${currentTotal.toStringAsFixed(2)} per basket",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,  
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            service.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          if (service.title != "FULL SERVICE") ...[
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Often purchased together",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    "Optional",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (service.title != "STEAM PRESS") _buildAddonOption(
                              title: "STEAM PRESS",
                              price: 95.00,
                              isSelected: hasSteamPress,
                              onChanged: (value) {
                                setModalState(() {
                                  hasSteamPress = value!;
                                  if (value) {
                                    currentTotal += 95.00;
                                  } else {
                                    currentTotal -= 95.00;
                                  }
                                });
                              },
                            ),
                            if (service.title != "DRY CLEAN") _buildAddonOption(
                              title: "DRY CLEAN", 
                              price: 80.00,
                              isSelected: hasDryClean,
                              onChanged: (value) {
                                setModalState(() {
                                  hasDryClean = value!;
                                  if (value) {
                                    currentTotal += 80.00;
                                  } else {
                                    currentTotal -= 80.00;
                                  }
                                });
                              },
                            ),
                            if (service.title != "WASH ONLY") _buildAddonOption(
                              title: "WASH ONLY",
                              price: 100.00, 
                              isSelected: hasWashOnly,
                              onChanged: (value) {
                                setModalState(() {
                                  hasWashOnly = value!;
                                  if (value) {
                                    currentTotal += 100.00;
                                  } else {
                                    currentTotal -= 100.00;
                                  }
                                });
                              },
                            ),
                          ],
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: service.isSelected 
                                  ? Colors.red 
                                  : const Color(0xFF1A0066),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (!service.isSelected) {
                                    service.isSelected = true;
                                    service.hasSteamPress = hasSteamPress;
                                    service.hasDryClean = hasDryClean; 
                                    service.hasWashOnly = hasWashOnly;
                                    totalPrice += currentTotal;
                                  } else {
                                    totalPrice -= service.totalPrice;
                                    service.isSelected = false;
                                    service.resetAddOns();
                                    hasSteamPress = false;
                                    hasDryClean = false;
                                    hasWashOnly = false;
                                  }
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                service.isSelected 
                                  ? "Remove from Basket"
                                  : "Add to Basket",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildAddonOption({
    required String title,
    required double price,
    required bool isSelected,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: isSelected,
            onChanged: onChanged,
            activeColor: const Color(0xFF1A0066),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          "+ ₱${price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1A0066),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/lavanderakocover.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF1A0066),
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () => _showDeliveryOptions(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            deliveryOption,
                            style: const TextStyle(
                              color: Color(0xFF1A0066),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            'assets/downarrow.png',
                            height: 16,
                            color: const Color(0xFF1A0066),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LaundryFullDetails(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/lavanderaakoprfile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Lavandera Ko",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "#123456ABCD",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/bluecircle.png', height: 16),
                              const SizedBox(width: 4),
                              Text(
                                "Ellis Angeles St. Naga City",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "4.6",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.star, size: 14, color: Colors.amber),
                            ],
                          ),
                          Text(
                            "Business Hours: 8:00am - 5:00pm",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: services.map((service) => ServiceCard(
                service: service,
                onTap: () => _showServiceDetails(service),
              )).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderConfirmScreen(
                userId: widget.userId,
                token: widget.token,
              ),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1A0066),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/basket.png', height: 24),
                      const SizedBox(width: 12),
                      const Text(
                        "Basket",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('assets/peso.png', height: 20),
                      Text(
                        " ${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: service.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₱${service.price.toStringAsFixed(2)} per basket",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              if (service.isSelected)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Color(0xFF1A0066),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}