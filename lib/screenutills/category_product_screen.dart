import 'dart:typed_data';
import 'package:blinker/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:blinker/constant/app_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryProductScreen extends StatefulWidget {
  final String categoryId;

  const CategoryProductScreen({required this.categoryId});

  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  List<dynamic> _products = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final url =
        '${AppConstant.LOCAL_API_URL}/api/v1/product/all-product/category/${widget.categoryId}';

    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _products = data['getAllProducts'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
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
                            name: product['name'] ?? 'Unknown',
                            description: product['description'] ?? '',
                            imageBytes: imageBytes,
                          );
                        },
                      ),
                    ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final Uint8List? imageBytes;

  const ProductCard({
    required this.name,
    required this.description,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageBytes != null
                  ? Image.memory(
                      imageBytes!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Icon(
                      Icons.image,
                      size: 60,
                      color: Colors.grey,
                    ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
