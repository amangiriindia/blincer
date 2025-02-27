import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CustomerSupportScreen extends StatelessWidget {
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
          'Blinker Support',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _buildSearchBar(),
            SizedBox(height: 20),
            // Quick Help Options
            Text(
              'Quick Help',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            _buildQuickHelpOptions(),
            SizedBox(height: 20),
            // FAQ Section
            Text(
              'FAQs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            _buildFAQSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.chat, color: Colors.white),
        onPressed: () {
          // Navigate to live chat screen
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for help...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildQuickHelpOptions() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildQuickHelpCard('Order Tracking', Icons.local_shipping),
        _buildQuickHelpCard('Returns & Refunds', Icons.assignment_return),
        _buildQuickHelpCard('Payment Issues', Icons.payment),
        _buildQuickHelpCard('Account Help', Icons.person),
      ],
    );
  }

  Widget _buildQuickHelpCard(String title, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Handle tap
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.green),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      children: [
        _buildFAQItem('How do I track my order?'),
        _buildFAQItem('What is your return policy?'),
        _buildFAQItem('How do I change my payment method?'),
        _buildFAQItem('How do I contact customer support?'),
      ],
    );
  }

  Widget _buildFAQItem(String question) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Answer to the question goes here...',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}