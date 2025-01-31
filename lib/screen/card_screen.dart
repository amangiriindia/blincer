import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../screenutills/product_details_screen.dart';
import '../service/card_service.dart';
import 'base/home_appbar.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  List<Map<String, dynamic>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() async {
    final items = await _cartService.getCartItems();
    setState(() {
      _cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(title: 'My Cart'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: _cartItems[index]['name'],
                  price: _cartItems[index]['price'].toDouble(), // Ensure price is a double
                  //image: _cartItems[index]['image'],
                  quantity: _cartItems[index]['quantity'],
                  onQuantityChanged: (newQuantity) {
                    _cartService.updateQuantity(_cartItems[index]['id'], newQuantity);
                    _loadCartItems();
                  },
                  onRemove: () {
                    _cartService.removeFromCart(_cartItems[index]['id']);
                    _loadCartItems();
                  },
                  onTap: () {
                    // Navigate to ProductDetailsScreen on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(productId: _cartItems[index]['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SummarySection(totalPrice: _calculateTotalPrice(_cartItems)),
        ],
      ),
    );
  }

  double _calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    return cartItems.fold(0.0, (sum, item) {
      // Ensure both price and quantity are used as double
      return sum + (item['price'].toDouble() * item['quantity']);
    });
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final double price; // Change price to double
  
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const ProductCard({
    required this.name,
    required this.price,
 
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Navigate to ProductDetailsScreen on tap
      child: Container(
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
                "",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
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
      ),
    );
  }
}

class SummarySection extends StatelessWidget {
  final double totalPrice; // Change totalPrice to double

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
