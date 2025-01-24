import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:blinker/constant/app_color.dart';
import '../screenutills/category_product_screen.dart';
import '../service/catrgory_service.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryService _categoryService = CategoryService();
  List<dynamic> _categories = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await _categoryService.getAllCategories();
      setState(() {
        _categories = categories;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: AppColor.primary,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Failed to load categories'))
              : _categories.isEmpty
                  ? Center(child: Text('No Categories Found'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final photoData = category['photo']?['data']?['data'];
                          Uint8List? imageBytes;

                          if (photoData != null) {
                            imageBytes = Uint8List.fromList(
                                List<int>.from(photoData));
                          }

                          return CategoryCard(
                            name: category['name'] ?? 'Unknown',
                            imageBytes: imageBytes,
                            categoryId :  category['_id'] ?? '6695f6bc8a516bd69f7c52e3',
                          );
                        },
                      ),
                    ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final Uint8List? imageBytes;
  final String categoryId; // Add categoryId

  const CategoryCard({
    required this.name,
    this.imageBytes,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to CategoryProductScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductScreen(categoryId: categoryId),
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
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
