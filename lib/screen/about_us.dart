import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AboutUsScreen extends StatelessWidget {
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
          'About Blinker',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Story Section
            _buildSectionTitle('Our Story'),
            SizedBox(height: 10),
            _buildBrandStory(),
            SizedBox(height: 20),
            // Team Section
            _buildSectionTitle('Meet the Team'),
            SizedBox(height: 10),
            _buildTeamSection(),
            SizedBox(height: 20),
            // Values Section
            _buildSectionTitle('Our Values'),
            SizedBox(height: 10),
            _buildValuesSection(),
            SizedBox(height: 20),
            // Call to Action
            _buildCallToAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _buildBrandStory() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Blinker was founded in 2023 with a mission to revolutionize the eCommerce experience. '
          'We aim to provide our customers with the best products, seamless shopping, and exceptional customer service. '
          'Our journey began with a small team of passionate individuals, and today we are proud to serve millions of customers worldwide.',
          style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.5),
        ),
      ),
    );
  }

  Widget _buildTeamSection() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildTeamMember('John Doe', 'CEO', 'assets/john_doe.jpg'),
        _buildTeamMember('Jane Smith', 'CTO', 'assets/jane_smith.jpg'),
        _buildTeamMember('Alice Brown', 'Marketing Head', 'assets/alice_brown.jpg'),
        _buildTeamMember('Bob Johnson', 'Lead Developer', 'assets/bob_johnson.jpg'),
      ],
    );
  }

  Widget _buildTeamMember(String name, String role, String imagePath) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 40,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            role,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection() {
    return Column(
      children: [
        _buildValueItem(Icons.thumb_up, 'Customer First', 'We prioritize our customers in every decision we make.'),
        _buildValueItem(   Icons.lightbulb_outline, 'Innovation', 'We constantly innovate to improve our products and services.'),
        _buildValueItem(Icons.eco, 'Sustainability', 'We are committed to eco-friendly practices and sustainability.'),
        _buildValueItem(Icons.people, 'Teamwork', 'We believe in collaboration and teamwork to achieve our goals.'),
      ],
    );
  }

  Widget _buildValueItem(IconData icon, String title, String description) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.green),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildCallToAction() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Navigate to contact or learn more screen
        },
        child: Text(
          'Learn More',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}