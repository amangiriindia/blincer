import 'package:blinker/screen/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ManageAddressesScreen extends StatelessWidget {
  // Dummy data for saved addresses
  final List<Map<String, String>> addresses = [
    {
      'name': 'John Doe',
      'address': '123 Main Street, Apt 4B, New York, NY 10001',
      'phone': '+1 123 456 7890',
    },
    {
      'name': 'Jane Smith',
      'address': '456 Elm Street, Suite 10, Los Angeles, CA 90001',
      'phone': '+1 987 654 3210',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Manage Addresses',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address List
            Text(
              'Saved Addresses',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            _buildAddressList(),
            SizedBox(height: 20),
            // Add New Address Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAddressScreen()),
                  );
                },
                child: Text(
                  'Add New Address',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return _buildAddressCard(addresses[index]);
      },
    );
  }

  Widget _buildAddressCard(Map<String, String> address) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              address['name']!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              address['address']!,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 5),
            Text(
              address['phone']!,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    // Navigate to edit address screen
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Delete address
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
