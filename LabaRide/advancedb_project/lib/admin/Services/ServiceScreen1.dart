import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../OrderScreen/OrderScreen.dart';
import '../ProfileAdmin/ProfileScreen.dart'; 
import '../CustomerOrder/CustomerOrder.dart';
import '../DashboardAdmin/homescreen.dart';

class ServiceScreen1 extends StatefulWidget {
  const ServiceScreen1({super.key});

  @override
  _ServiceScreen1State createState() => _ServiceScreen1State();
}

class _ServiceScreen1State extends State<ServiceScreen1> {
  // List of services
  final List<Map<String, dynamic>> _services = [
    {'name': 'WASH ONLY', 'color': const Color.fromARGB(255, 90, 176, 144)},
    {'name': 'STEAM PRESS', 'color': const Color.fromARGB(255, 129, 212, 250)},
    {'name': 'DRY CLEAN', 'color': const Color.fromARGB(255, 76, 43, 197)},
    {'name': 'FULL SERVICE', 'color': const Color(0xFF1A0066)},
  ];

  final Map<String, String> savedPrices = {
    'SHIRTS': '',
    'PANTS': '',
    'DRESSES': '',
    'JACKETS': '',
    'UNIFORMS': '',
    'UNDERGARMENTS': '',
    'SOCKS': '',
  };

  final Map<String, String> householdItems = {
    'BLANKETS': '',
    'BED SHEETS': '',
    'PILLOWCASES': '',
    'CURTAINS': '',
    'TABLECLOTHS': '',
  };

  // Track whether we are in "edit mode"
  bool _isEditing = false;

  // Add a new service
  void _addService(String serviceName, Color color) {
    setState(() {
      _services.add({'name': serviceName, 'color': color});
    });
  }

  // Remove a service
  void _removeService(int index) {
    setState(() {
      _services.removeAt(index);
    });
  }

  void _showAddClothingDialog(
    BuildContext context,
    StateSetter setState,
    Map<String, TextEditingController> priceControllers,
  ) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Clothing Type'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter clothing type'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newClothing = nameController.text.trim().toUpperCase();
                if (newClothing.isNotEmpty &&
                    !savedPrices.containsKey(newClothing)) {
                  setState(() {
                    savedPrices[newClothing] = '';
                    priceControllers[newClothing] =
                        TextEditingController(); // Add controller
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAddHouseholdItemDialog(
    BuildContext context,
    StateSetter setState,
    Map<String, TextEditingController> itemControllers,
  ) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Household Item'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter item name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newItem = nameController.text.trim().toUpperCase();
                if (newItem.isNotEmpty &&
                    !householdItems.containsKey(newItem)) {
                  setState(() {
                    householdItems[newItem] = '';
                    itemControllers[newItem] =
                        TextEditingController(); // Add controller
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showHouseholdItemsPopup(BuildContext context) {
    final Map<String, TextEditingController> itemControllers = {
      for (var key in householdItems.keys)
        key: TextEditingController(text: householdItems[key]),
    };

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), // Light purple background
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Edit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'HOUSEHOLD ITEMS',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A0066), // Dark blue text
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isEditing ? Icons.done : Icons.edit,
                          color: const Color(0xFF1A0066),
                        ),
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing; // Toggle edit mode
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // List of Household Items
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children:
                          householdItems.keys.map((key) {
                            return _buildEditableHouseholdItemTile(
                              context,
                              key,
                              itemControllers[key]!,
                              householdItems,
                              _isEditing,
                              () {
                                // Handle deletion
                                setState(() {
                                  householdItems.remove(key);
                                  itemControllers.remove(key);
                                });
                              },
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Add and Remove Buttons
                  if (_isEditing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _showAddHouseholdItemDialog(
                              context,
                              setState,
                              itemControllers,
                            );
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Add Item',
                            style: TextStyle(
                              color: Colors.white,
                            ), // Set text color to white
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A0066),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              householdItems.clear();
                              itemControllers.clear();
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text(
                            'Remove All',
                            style: TextStyle(
                              color: Colors.white,
                            ), // Set text color to white
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      // Save prices when closing the popup
                      itemControllers.forEach((key, controller) {
                        householdItems[key] = controller.text;
                      });
                      Navigator.pop(context); // Close the popup
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A0066), // Dark blue
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
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

  // Show popup for "Types of Clothes"
  void _showTypesOfClothesPopup(BuildContext context) {
    final Map<String, TextEditingController> priceControllers = {
      for (var key in savedPrices.keys)
        key: TextEditingController(text: savedPrices[key]),
    };

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255), // Light purple background
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Edit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TYPES OF CLOTHES',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A0066), // Dark blue text
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isEditing ? Icons.done : Icons.edit,
                          color: const Color(0xFF1A0066),
                        ),
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing; // Toggle edit mode
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // List of Clothes
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children:
                          savedPrices.keys.map((key) {
                            return _buildEditableClothesListTile(
                              context,
                              key,
                              priceControllers[key]!,
                              savedPrices,
                              _isEditing,
                              () {
                                // Handle deletion
                                setState(() {
                                  savedPrices.remove(key);
                                  priceControllers.remove(key);
                                });
                              },
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Add and Remove Buttons
                  if (_isEditing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _showAddClothingDialog(
                              context,
                              setState,
                              priceControllers,
                            );
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Add Clothing',
                            style: TextStyle(
                              color: Colors.white,
                            ), // Set text color to white
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF1A0066,
                            ), // Button background color
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              savedPrices.clear();
                              priceControllers.clear();
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text(
                            'Remove All',
                            style: TextStyle(
                              color: Colors.white,
                            ), // Set text color to white
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      // Save prices when closing the popup
                      priceControllers.forEach((key, controller) {
                        savedPrices[key] = controller.text;
                      });
                      Navigator.pop(context); // Close the popup
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A0066), // Dark blue
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
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

  Widget _buildEditableClothesListTile(
    BuildContext context,
    String title,
    TextEditingController priceController,
    Map<String, String> savedPrices,
    bool isEditing,
    VoidCallback onDelete, // Add this argument
  ) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold, // Clothes names are bold
          color: Color(0xFF1A0066), // Dark blue text
        ),
      ),
      trailing:
          isEditing
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only numbers
                        LengthLimitingTextInputFormatter(
                          4,
                        ), // Limit to 4 digits
                      ],
                      decoration: const InputDecoration(
                        hintText: '₱0',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // Save the price directly to the savedPrices map
                        savedPrices[title] = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onDelete, // Call the delete callback
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.remove, // Use the remove icon
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : Text(
                savedPrices[title]?.isEmpty ?? true
                    ? '₱--'
                    : '₱${savedPrices[title]}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal, // Prices are not bold
                  color: Color(0xFF1A0066), // Dark blue text
                ),
              ),
    );
  }

  Widget _buildEditableHouseholdItemTile(
    BuildContext context,
    String title,
    TextEditingController priceController,
    Map<String, String> householdItems,
    bool isEditing,
    VoidCallback onDelete, // Callback to handle deletion
  ) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold, // Item names are bold
          color: Color(0xFF1A0066), // Dark blue text
        ),
      ),
      trailing:
          isEditing
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only numbers
                        LengthLimitingTextInputFormatter(
                          4,
                        ), // Limit to 4 digits
                      ],
                      decoration: const InputDecoration(
                        hintText: '₱0',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // Save the price directly to the householdItems map
                        householdItems[title] = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onDelete, // Call the delete callback
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.remove, // Use the remove icon
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : Text(
                householdItems[title]?.isEmpty ?? true
                    ? '₱--'
                    : '₱${householdItems[title]}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal, // Prices are not bold
                  color: Color(0xFF1A0066), // Dark blue text
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: const Text(
          'SERVICES',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A0066),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF1A0066)),
            onPressed: () {
              // Show modal bottom sheet for editing services
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.add, color: Colors.green),
                          title: const Text('Add Service'),
                          onTap: () {
                            Navigator.pop(context);
                            _showAddServiceDialog(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.remove, color: Colors.red),
                          title: const Text('Remove Service'),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _isEditing = true; // Enable edit mode
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dynamically build service buttons
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(_services.length, (index) {
                  final service = _services[index];
                  return Stack(
                    children: [
                      _buildServiceButton(
                        context,
                        service['name'],
                        service['color'],
                      ),
                      if (_isEditing) // Show close button only in edit mode
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              _removeService(index);
                            },
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.remove, // Use the remove icon
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Prices Section
              const Text(
                'PRICES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A0066),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPriceCard(
                    context,
                    'TYPES OF CLOTHES',
                    'assets/ServicesScreen/typeclothes.png',
                    onTap: () {
                      _showTypesOfClothesPopup(context);
                    },
                  ),
                  _buildPriceCard(
                    context,
                    'HOUSEHOLD ITEMS',
                    'assets/ServicesScreen/householditems.png',
                    onTap: () {
                      _showHouseholdItemsPopup(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          _isEditing
              ? FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    _isEditing = false; // Disable edit mode
                  });
                },
                label: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white), // White text
                ),
                icon: const Icon(Icons.done, color: Colors.white), // White icon
                backgroundColor: Colors.blue,
              )
              : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1A0066),
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          }
          if (index == 1) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionsScreen(),
              ),
            );
          }
         if (index == 3) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerOrders(),
              ),
            );
          }
         if (index == 4) {
            // Navigate to IndividualTransact page when "Orders" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenAdmin(),
              ),
            );
          }
        },
        items: [
          _buildNavItem('Home', 'assets/OrderScreenIcon/Home.png'),
          _buildNavItem('Orders', 'assets/OrderScreenIcon/Orders.png'),
          _buildNavItem('Services', 'assets/OrderScreenIcon/Services.png'),
          _buildNavItem('Customers', 'assets/OrderScreenIcon/Customers.png'),
          _buildNavItem('Profile', 'assets/OrderScreenIcon/Profile.png'),
        ],
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    Color selectedColor = const Color.fromARGB(
      255,
      90,
      176,
      144,
    ); // Default color

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Service'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter service name',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select Color:'),
                      DropdownButton<Color>(
                        value: selectedColor,
                        items:
                            [
                              const Color.fromARGB(255, 90, 176, 144), // Green
                              const Color.fromARGB(
                                255,
                                129,
                                212,
                                250,
                              ), // Light Blue
                              const Color.fromARGB(255, 76, 43, 197), // Purple
                              const Color(0xFF1A0066), // Dark Blue
                              const Color.fromARGB(255, 148, 19, 10), // Red
                            ].map((color) {
                              return DropdownMenuItem(
                                value: color,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  color: color,
                                ),
                              );
                            }).toList(),
                        onChanged: (color) {
                          setState(() {
                            selectedColor = color!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Quick Add:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            90,
                            176,
                            144,
                          ), // Green
                        ),
                        onPressed: () {
                          _addService(
                            'WASH ONLY',
                            const Color.fromARGB(255, 90, 176, 144),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'WASH ONLY',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            129,
                            212,
                            250,
                          ), // Light Blue
                        ),
                        onPressed: () {
                          _addService(
                            'STEAM PRESS',
                            const Color.fromARGB(255, 129, 212, 250),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'STEAM PRESS',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            76,
                            43,
                            197,
                          ), // Purple
                        ),
                        onPressed: () {
                          _addService(
                            'DRY CLEAN',
                            const Color.fromARGB(255, 76, 43, 197),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'DRY CLEAN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A0066), // Dark Blue
                        ),
                        onPressed: () {
                          _addService('FULL SERVICE', const Color(0xFF1A0066));
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'FULL SERVICE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  _addService(controller.text.toUpperCase(), selectedColor);
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildServiceButton(BuildContext context, String label, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceCard(
    BuildContext context,
    String label,
    String iconPath, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF1A0066), width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(iconPath, height: 40),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0066),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, String iconPath) {
    return BottomNavigationBarItem(
      icon: Image.asset(iconPath, height: 24, color: Colors.grey),
      activeIcon: Image.asset(
        iconPath,
        height: 24,
        color: const Color(0xFF1A0066),
      ),
      label: label,
    );
  }
}
