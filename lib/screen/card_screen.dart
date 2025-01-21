import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'base/home_appbar.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Wireless Headphones",
      "price": 59.99,
      "image": "https://via.placeholder.com/150/0000FF/808080?text=Headphones",
      "quantity": 1,
    },
    {
      "name": "Smart Watch",
      "price": 199.99,
      "image": "https://via.placeholder.com/150/008000/FFFFFF?text=Smart+Watch",
      "quantity": 1,
    },
    {
      "name": "Bluetooth Speaker",
      "price": 99.99,
      "image": "https://via.placeholder.com/150/DC143C/FFFFFF?text=Speaker",
      "quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar:  HomeAppBar(title: 'My Cart',),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: cartItems[index]['name'],
                  price: cartItems[index]['price'],
                  image: cartItems[index]['image'],
                  quantity: cartItems[index]['quantity'],
                  onQuantityChanged: (newQuantity) {
                    // Handle quantity change logic
                    print("New quantity for ${cartItems[index]['name']}: $newQuantity");
                  },
                  onRemove: () {
                    // Handle item removal
                    print("Removed ${cartItems[index]['name']} from cart");
                  },
                );
              },
            ),
          ),
          SummarySection(totalPrice: _calculateTotalPrice(cartItems)),
        ],
      ),
    );
  }

  double _calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    return cartItems.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const ProductCard({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Fallback UI for broken image
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[200],
            child: Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: 40,
            ),
          );
        },
      ),
    ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                onQuantityChanged(quantity - 1);
                              }
                            },
                            icon: Icon(Icons.remove_circle_outline, color: AppColor.secondary),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              onQuantityChanged(quantity + 1);
                            },
                            icon: Icon(Icons.add_circle_outline, color: AppColor.secondary),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: onRemove,
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummarySection extends StatelessWidget {
  final double totalPrice;

  const SummarySection({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle checkout action
              print("Proceed to Checkout");
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: AppColor.primary,
            ),
            child: Center(
              child: Text(
                "Proceed to Checkout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
