import 'dart:typed_data';
import 'package:blinker/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:blinker/constant/app_color.dart';
import '../service/catrgory_service.dart';

class CategoryProductScreen extends StatefulWidget {
  final String categoryId;

  const CategoryProductScreen({required this.categoryId});

  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  final CategoryService _categoryService = CategoryService();
  List<dynamic> _products = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products =
          await _categoryService.getProductsByCategory(widget.categoryId);
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Products'),
        backgroundColor: AppColor.primary,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Failed to load products'))
              : _products.isEmpty
                  ? Center(child: Text('No Products Found'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          final photoData =
                              product['store']?['logo']?['Data']?['data'];
                          Uint8List? imageBytes;

                          if (photoData != null) {
                            imageBytes =
                                Uint8List.fromList(List<int>.from(photoData));
                          }

                          return ProductCard(
                            id:product['_id'] ,
                            name: product['name'] ?? 'Unknown',
                            price: product['price']?.toString() ?? 'N/A',
                            imageBytes: imageBytes,
                          );
                        },
                      ),
                    ),
    );
  }
}


