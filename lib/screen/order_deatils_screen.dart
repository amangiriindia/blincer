import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderDetailsScreen({required this.order});

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
          'Order Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            _buildOrderSummary(),
            SizedBox(height: 20),
            // Tracking Animation
            _buildTrackingAnimation(),
            SizedBox(height: 20),
            // Ordered Items
            Text(
              'Ordered Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            _buildOrderedItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order['id']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text('Date: ${order['date']}'),
            Text('Status: ${order['status']}'),
            Text('Total: ${order['total']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingAnimation() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Track Order',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            _buildTimeline(),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0);
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineStep('Order Placed', true),
        _buildTimelineStep('Processing', order['status'] != 'Delivered'),
        _buildTimelineStep('Shipped', order['status'] == 'Shipped' || order['status'] == 'Delivered'),
        _buildTimelineStep('Delivered', order['status'] == 'Delivered'),
      ],
    );
  }

  Widget _buildTimelineStep(String step, bool isCompleted) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 10),
        Text(
          step,
          style: TextStyle(fontSize: 16, color: isCompleted ? Colors.black : Colors.grey),
        ),
      ],
    );
  }

  Widget _buildOrderedItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3, // Replace with actual item count
      itemBuilder: (context, index) {
        return _buildOrderItem();
      },
    );
  }

  Widget _buildOrderItem() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset('assets/product_image.png', width: 50, height: 50),
        title: Text('Product Name'),
        subtitle: Text('Quantity: 1 | Price: \$19.99'),
      ),
    );
  }
}