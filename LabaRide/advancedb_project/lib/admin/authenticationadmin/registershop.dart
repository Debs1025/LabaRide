import 'package:flutter/material.dart';
import 'signup_admin.dart';
import 'signupcomplete_admin.dart';

class ServicePrice {
  String name;
  String price;
  ServicePrice({required this.name, required this.price});
}

class RegisterShop extends StatefulWidget {
  const RegisterShop({super.key});

  @override
  State<RegisterShop> createState() => _RegisterShopState();
}

class _RegisterShopState extends State<RegisterShop> {
  final _formKey = GlobalKey<FormState>();
  final _customServiceController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _zoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _barangayController = TextEditingController();
  final _buildingController = TextEditingController();
  final _openingTimeController = TextEditingController();
  final _closingTimeController = TextEditingController();
  
  List<ServicePrice> services = [];
  List<String> predefinedServices = [
    'Wash Only',
    'Dry Clean',
    'Full Service',
    'Add Custom Service',
  ];

  bool _isFormValid() {
    return _shopNameController.text.isNotEmpty &&
        _contactNumberController.text.isNotEmpty &&
        _zoneController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _barangayController.text.isNotEmpty &&
        _openingTimeController.text.isNotEmpty &&
        _closingTimeController.text.isNotEmpty &&
        services.isNotEmpty &&
        services.every((service) => service.price.isNotEmpty);
  }

  @override
  void dispose() {
    _customServiceController.dispose();
    _shopNameController.dispose();
    _contactNumberController.dispose();
    _zoneController.dispose();
    _streetController.dispose();
    _barangayController.dispose();
    _buildingController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    super.dispose();
  }

  void _addService(String serviceName) {
    setState(() {
      if (!services.any((s) => s.name == serviceName)) {
        services.add(ServicePrice(name: serviceName, price: ''));
      }
    });
  }

  void _showCustomServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Custom Service',
          style: TextStyle(
            color: Color(0xFF1A0066),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        content: TextField(
          controller: _customServiceController,
          decoration: InputDecoration(
            hintText: 'Enter service name',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF7678A5)),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_customServiceController.text.isNotEmpty) {
                _addService(_customServiceController.text);
                _customServiceController.clear();
              }
              Navigator.pop(context);
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Color(0xFF7678A5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool required = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: 'Inter',
                ),
              ),
              if (required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1A0066),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildDocumentUpload(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, size: 32, color: Colors.grey[400]),
                const SizedBox(height: 8),
                Text(
                  'Upload Photo',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Services and Price'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text(
                'Add Service',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: predefinedServices
                  .where((service) => 
                    service == 'Add Custom Service' || 
                    !services.any((s) => s.name == service))
                  .map((String service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(
                    service,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value == 'Add Custom Service') {
                  _showCustomServiceDialog();
                } else if (value != null) {
                  _addService(value);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: services.map((service) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      service.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        service.price = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Price',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
                    onPressed: () {
                      setState(() => services.remove(service));
                    },
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A0066)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreenAdmin()),
            );
          },
        ),
        title: Row(
          children: [
            Image.asset('assets/blacklogo.png', height: 35),
            const SizedBox(width: 10),
            const Text(
              'Register your shop',
              style: TextStyle(
                color: Color(0xFF1A0066),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Shop Information'),
                _buildTextField('Shop Name', 'Enter shop name', _shopNameController),
                _buildTextField('Contact Number', 'Enter contact number', _contactNumberController),
                const SizedBox(height: 24),

                _buildSectionTitle('Address'),
                _buildTextField('Zone Name', 'Enter zone', _zoneController),
                _buildTextField('Street Name', 'Enter street name', _streetController),
                _buildTextField('Barangay Name', 'Enter barangay name', _barangayController),
                _buildTextField('Building Name', 'Enter building name', _buildingController, required: false),
                const SizedBox(height: 24),

                _buildSectionTitle('Business Requirements'),
                _buildDocumentUpload('DTI Certificate *'),
                _buildDocumentUpload('SEC Registration *'),
                _buildDocumentUpload('TIN ID *'),
                _buildDocumentUpload("Mayor's Permit *"),
                const SizedBox(height: 24),

                _buildSectionTitle('Business Hours'),
                _buildTextField('Opening Time', 'Enter opening time (eg. 5:00am)', _openingTimeController),
                _buildTextField('Closing Time', 'Enter closing time (eg. 11:00pm)', _closingTimeController),
                const SizedBox(height: 24),

                _buildServicesSection(),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isFormValid() ? () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpCompleteScreen(),
                          ),
                        );
                      }
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid() ? const Color(0xFF7678A5) : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _isFormValid() ? Colors.white : Colors.grey[500],
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}