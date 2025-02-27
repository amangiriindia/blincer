import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SettingsScreen extends StatelessWidget {
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
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Account Settings
            _buildSectionTitle('Account Settings'),
            _buildSettingItem(Icons.person, 'Edit Profile', () {
              // Navigate to edit profile screen
            }),
            _buildSettingItem(Icons.lock, 'Change Password', () {
              // Navigate to change password screen
            }),
            SizedBox(height: 20),
            // App Preferences
            _buildSectionTitle('App Preferences'),
            _buildSettingItem(Icons.notifications, 'Notifications', null, isToggle: true),
            _buildSettingItem(Icons.dark_mode, 'Dark Mode', null, isToggle: true),
            _buildSettingItem(Icons.language, 'Language', () {
              // Navigate to language settings screen
            }),
            SizedBox(height: 20),
            // Support
            _buildSectionTitle('Support'),
            _buildSettingItem(Icons.help, 'Help Center', () {
              // Navigate to help center
            }),
            _buildSettingItem(Icons.contact_support, 'Contact Support', () {
              // Navigate to contact support
            }),
            SizedBox(height: 20),
            // About
            _buildSectionTitle('About'),
            _buildSettingItem(Icons.info, 'About Blinker', () {
              // Navigate to about screen
            }),
            _buildSettingItem(Icons.privacy_tip, 'Privacy Policy', () {
              // Navigate to privacy policy
            }),
            _buildSettingItem(Icons.description, 'Terms of Service', () {
              // Navigate to terms of service
            }),
            SizedBox(height: 20),
            // App Version
            Text(
              'App Version: 1.0.0',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, Function()? onTap, {bool isToggle = false}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        trailing: isToggle
            ? Switch(
                value: true, // Replace with actual state
                onChanged: (value) {
                  // Handle toggle
                },
                activeColor: Colors.green,
              )
            : Icon(Icons.arrow_forward_ios, color: Colors.green),
        onTap: onTap,
      ),
    );
  }
}