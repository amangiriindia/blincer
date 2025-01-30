import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:blinker/constant/app_color.dart';
import '../service/wishlist_service.dart';
import 'base/home_appbar.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final WishlistService _wishlistService = WishlistService();
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadWishlistItems();
  }

  // Load all wishlist items from the database
  void _loadWishlistItems() async {
    final items = await _wishlistService.getWishlist();
    setState(() {
      favoriteItems = items;
    });
  }

  // Handle item like/dislike functionality
  void _toggleFavorite(Map<String, dynamic> item) {
    if (favoriteItems.any((element) => element['id'] == item['id'])) {
      _wishlistService.removeFromWishlist(item['id']);
    } else {
      _wishlistService.addToWishlist(item);
    }
    _loadWishlistItems(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(title: 'Favorites'),
      body: Container(
        child: favoriteItems.isEmpty
            ? Center(child: Text('No items in the wishlist.'))
            : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  final int price = item["price"] ?? 0; // Assuming price is available
                
                    Uint8List? imageBytes;
      if (item['itemImage'] != null && item['itemImage']['data'] != null) {
        imageBytes = Uint8List.fromList(List<int>.from(item['itemImage']['data']));
      }

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
                              child: imageBytes != null
                                  ? Image.memory(
                                      imageBytes,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      width: 100,
                                      height: 100,
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey[500],
                                      ),
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
                                      item["name"] ?? 'No Name', // Display the name
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.currency_rupee, size: 14, color: Colors.black),
                                        Text(
                                          "$price",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Favorite Icon (Like/Dislike)
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: favoriteItems.any((element) => element['id'] == item['id'])
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                _toggleFavorite(item);
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
