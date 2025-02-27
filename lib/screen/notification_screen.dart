import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Dummy notifications list
  List<Map<String, String>> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? _buildNoNotifications()
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(notifications[index]);
              },
            ),
    );
  }

  Widget _buildNoNotifications() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off, size: 80, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            'No notifications found',
            style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, String> notification) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.green.withOpacity(0.2),
          child: Icon(Icons.notifications, color: Colors.green),
        ),
        title: Text(
          notification['title']!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(notification['message']!),
        trailing: Text(
          notification['time']!,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
