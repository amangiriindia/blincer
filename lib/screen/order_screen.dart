import 'package:blinker/screen/order_deatils_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class OrderScreen extends StatelessWidget {
  // Dummy data for orders
  final List<Map<String, dynamic>> orders = [
    {
      'id': '#123456',
      'date': 'Oct 10, 2023',
      'status': 'Delivered',
      'total': '\$99.99',
    },
    {
      'id': '#123457',
      'date': 'Oct 12, 2023',
      'status': 'Shipped',
      'total': '\$49.99',
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
          'My Orders',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(orders[index], context);
        },
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          'Order ID: ${order['id']}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${order['date']}'),
            Text('Status: ${order['status']}'),
            Text('Total: ${order['total']}'),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(order: order),
            ),
          );
        },
      ),
    );
  }
}