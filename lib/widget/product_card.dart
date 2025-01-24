import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../screenutills/product_details_screen.dart';

class ProductCard extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final Uint8List? imageBytes;

  const ProductCard({
    required this.name,
    required this.price,
    this.imageBytes,
    required this.id, // Add Product ID
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlist = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(productId: widget.id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Section
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      child: widget.imageBytes != null
                          ? Image.memory(
                              widget.imageBytes!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Icon(
                              Icons.image,
                              size: 60,
                              color: Colors.grey,
                            ),
                    ),
                    // Wishlist Icon
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isWishlist = !isWishlist;
                          });
                        },
                        child: Icon(
                          isWishlist ? Icons.favorite : Icons.favorite_border,
                          color: isWishlist ? Colors.red : Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              // Name
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primary,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              // Price
              Text(
                '₹ ${widget.price}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              // Add to Cart Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle add to cart logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                  icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ));
  }
}
