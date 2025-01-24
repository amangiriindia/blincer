import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../service/product_service.dart';


class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({required this.productId, Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isLoading = true;
  Map<String, dynamic>? productDetails;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      final product = await ProductService().fetchSingleProduct(widget.productId);
      setState(() {
        productDetails = product;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: AppColor.primary,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : productDetails == null
              ? Center(child: Text('Failed to load product details.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      if (productDetails!['store']['logo'] != null)
                        Image.memory(
                          Uint8List.fromList(
                            List<int>.from(
                              productDetails!['store']['logo']['Data']['data'],
                            ),
                          ),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      SizedBox(height: 16),
                      // Product Name
                      Text(
                        productDetails!['name'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Product Description
                      Text(
                        productDetails!['description'] ?? 'No description available.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      // Product Status
                      Text(
                        'Status: ${productDetails!['status'] ? 'Available' : 'Unavailable'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: productDetails!['status'] ? Colors.green : Colors.red,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Modules
                      Text(
                        'Module: ${productDetails!['modules']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
    );
  }
}
