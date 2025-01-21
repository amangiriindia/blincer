import 'package:blinker/constant/app_color.dart';
import 'package:flutter/material.dart';

import 'base/home_appbar.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteItems = [
    {
      "image": "https://via.placeholder.com/150",
      "title": "Product 1",
      "description": "Description of Product 1",
    },
    {
      "image": "https://via.placeholder.com/150",
      "title": "Product 2",
      "description": "Description of Product 2",
    },
    {
      "image": "https://via.placeholder.com/150",
      "title": "Product 3",
      "description": "Description of Product 3",
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:  HomeAppBar(title: 'Favorites',),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Row(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          favoriteItems[index]["image"]!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.broken_image,
                                size: 40,
                                color: Colors.grey[500],
                              ),
                            );
                          },
                        ),
                      ),
                      // Item Details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                favoriteItems[index]["title"]!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                favoriteItems[index]["description"]!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Favorite Icon
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          // Implement favorite toggle functionality
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
