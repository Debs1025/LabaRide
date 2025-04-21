import 'package:flutter/material.dart';
import 'OrderDeclined.dart';

class DeclineOrder4 extends StatefulWidget {
  final String reason; // Reason for declining (e.g., "Service currently unavailable")

  const DeclineOrder4({super.key, required this.reason});

  @override
  _DeclineOrder4State createState() => _DeclineOrder4State();
}

class _DeclineOrder4State extends State<DeclineOrder4> {
  // Track the selected services
  final Map<String, bool> services = {
    'Wash Only': false,
    'Dry Clean': false,
    'Steam Press': false,
    'Full Service': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A0066)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF9747FF),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Which services are unavailable?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0066),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'These services will be set to unavailable for the rest of the day.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: services.keys.map((service) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: services[service],
                          onChanged: (bool? value) {
                            setState(() {
                              services[service] = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: _getServiceColor(service),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              service.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: services.containsValue(true)
                    ? () {
                        // Collect selected services (removed unused variable)
                        services.entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList();

                        // Navigate to OrderDeclined screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDeclined(),
                          ),
                        );
                      }
                    : null, // Disable button if no service is selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: services.containsValue(true)
                      ? const Color(0xFF1A0066)
                      : const Color(0xFFE5E7EB),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50), // Set button width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: services.containsValue(true)
                        ? Colors.white
                        : const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get the color for each service
  Color _getServiceColor(String service) {
    switch (service) {
      case 'Wash Only':
        return const Color(0xFF6FCF97); // Green
      case 'Dry Clean':
        return const Color(0xFF9747FF); // Purple
      case 'Steam Press':
        return const Color(0xFF56CCF2); // Light Blue
      case 'Full Service':
        return const Color(0xFF1A0066); // Dark Blue
      default:
        return Colors.grey;
    }
  }
}