import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signupcomplete.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;
  final String token;

  const UserDetailsScreen({
    super.key,
    required this.userId,
    this.token = '', 
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _barangayController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  String? selectedGender;

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate() || selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/update_user_details/${widget.userId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode({
          'phone': _phoneController.text,
          'birthdate': _birthdateController.text,
          'gender': selectedGender,
          'zone': _zoneController.text,
          'street': _streetController.text,
          'barangay': _barangayController.text,
          'building': _buildingController.text,
        }),
      );

      if (response.statusCode == 200) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpCompleteScreen()),
        );
      } else {
        throw Exception('Failed to update user details');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(  // Added Form widget
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'assets/blacklogo.png',
                            height: 60,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Set up your details',
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A0066),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Form section
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F1F39),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildLabeledField(
                        'Contact Number',
                        'Enter contact number',
                        controller: _phoneController,
                        prefix: '+63',
                      ),
                      
                      _buildLabeledField(
                        'Birthdate',
                        'MM/DD/YYYY',
                        controller: _birthdateController,
                        suffixIcon: Icons.calendar_today,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                      ),

                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDropdownField(),
                      const SizedBox(height: 24),

                      const Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F1F39),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildLabeledField('Zone Name', 'Enter zone', controller: _zoneController),
                      _buildLabeledField('Street Name', 'Enter street name', controller: _streetController),
                      _buildLabeledField('Barangay Name', 'Enter barangay name', controller: _barangayController),
                      _buildLabeledField('Building Name (Optional)', 'Enter building name', controller: _buildingController),
                      
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF375DFB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
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
    );
  }

  Widget _buildInputField(String hint, {
    String? prefix,
    IconData? suffixIcon,
    TextEditingController? controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(  // Changed from TextField to TextFormField
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixText: prefix,
        prefixStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        suffixIcon: suffixIcon != null 
            ? Icon(suffixIcon, color: Colors.grey[400], size: 20)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedGender,
          hint: Text(
            'Select gender',
            style: TextStyle(color: Colors.grey[400]),
          ),
          items: ['Male', 'Female', 'Other']
              .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildLabeledField(
    String label,
    String hint, {
    TextEditingController? controller,
    String? prefix,
    IconData? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          _buildInputField(
            hint,
            controller: controller,
            prefix: prefix,
            suffixIcon: suffixIcon,
            readOnly: readOnly,
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _birthdateController.dispose();
    _zoneController.dispose();
    _streetController.dispose();
    _barangayController.dispose();
    _buildingController.dispose();
    super.dispose();
  }
}