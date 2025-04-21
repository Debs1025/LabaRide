import 'package:flutter/material.dart';

class LaundryFullDetails extends StatelessWidget {
  const LaundryFullDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0066), // Changed to navy blue
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Full Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lavandera Ko",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0066),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Shop ID: #123456ABCD",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  "4.6",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A0066),
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 20,
                      color: index < 4 ? Colors.amber : Colors.amber[200],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "200 ratings",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            // Rating Distribution
            Row(
              children: [
                const Text("5", style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.8,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("80%", style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("4", style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.15,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("15%", style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("3", style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.03,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("3%", style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("2", style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.01,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("1%", style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("1", style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.01,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("1%", style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "About",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A0066),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Pricing",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A0066),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Prices may vary based on the transaction of the user. Prices are also changed by the admin.",
              style: TextStyle(
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Business Hours",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A0066),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monday to Sunday:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "8:00am - 5:00pm",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Holidays:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Time may vary",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Address",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A0066),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "J6GP+Q84, Elias Angeles St., Corner Paz St., Barangay Sta. Cruz, Naga City",
              style: TextStyle(
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}