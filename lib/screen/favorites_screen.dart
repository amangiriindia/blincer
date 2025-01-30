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
                                item["image"], // Assuming the image is a URL
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
                                      item["name"], // Display the name
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      item["description"] ?? 'No description',
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
