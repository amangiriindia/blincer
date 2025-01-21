import 'package:blinker/constant/app_color.dart';
import 'package:blinker/screen/base/home_appbar.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Electronics", "image": "https://via.placeholder.com/150/0000FF/808080?text=Electronics"},
    {"name": "Fashion", "image": "https://via.placeholder.com/150/FF69B4/808080?text=Fashion"},
    {"name": "Home Decor", "image": "https://via.placeholder.com/150/008000/FFFFFF?text=Home+Decor"},
    {"name": "Beauty", "image": "https://via.placeholder.com/150/FFD700/808080?text=Beauty"},
    {"name": "Toys", "image": "https://via.placeholder.com/150/FFA500/808080?text=Toys"},
    {"name": "Sports", "image": "https://via.placeholder.com/150/DC143C/FFFFFF?text=Sports"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(title: 'Categories',),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 3 / 4,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                name: categories[index]['name']!,
                image: categories[index]['image']!,
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String image;

  const CategoryCard({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to category details or list of products
        print('Tapped on $name');
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
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error, color: Colors.red));
                  },
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
