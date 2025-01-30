import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import '../constant/app_color.dart';
import '../constant/voice_to_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screenutills/product_details_screen.dart';
import '../service/product_service.dart';
import '../service/weather_service.dart';
import '../service/wishlist_service.dart';
import '../widget/location_popup.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  String name = 'Blinker User';
  String currentLocation = 'Fetching...';
  String weatherCondition = '';
  String weatherIconUrl = '';
  double temperature = 0.0;
  String? currentAddress;
  final ProductService _productService = ProductService();
  List<dynamic> _products = [];
  bool _isLoading = true;
  final WishlistService wishlistService = WishlistService();

  @override
  void initState() {
    super.initState();
    // _getCurrentWeather('Bengaluru'); // Default city
    _fetchProducts();
  }

  void _showLocationModal() {
    showLocationModal(context);
  }

  Future<void> _fetchProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final products = await _productService.fetchProducts('grocery');
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching products: $e');
    }
  }

  Future<void> _getCurrentWeather(String city) async {
    try {
      final weatherData = await _weatherService.getWeather(city);
      setState(() {
        weatherCondition = weatherData['current']['condition']['text'];
        weatherIconUrl = "https:${weatherData['current']['condition']['icon']}";
        temperature = weatherData['current']['temp_c'];
        currentLocation = weatherData['location']['name'];
      });
    } catch (e) {
      setState(() {
        weatherCondition = 'Error fetching weather';
        weatherIconUrl = '';
        temperature = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.secondary],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: _showLocationModal,
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    currentLocation,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {}, // Add functionality for notifications
              child: Icon(Icons.notifications, color: Colors.white),
            ),
          ],
        ),
      ),
      headerWidget: _buildHeaderWidget(),
      body: [_buildBodyContent()],
    );
  }

  Widget _buildHeaderWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [AppColor.primary, AppColor.secondary]),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          weatherIconUrl.isNotEmpty
              ? Image.network(weatherIconUrl, height: 50)
              : Icon(Icons.cloud,
                  color: Colors.white, size: 50), // Default cloud icon
          SizedBox(height: 8),
          Text(
            "$weatherCondition | ${temperature.toStringAsFixed(1)}°C",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text("Welcome to Blincer",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Your one-stop shop for everything!",
              style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          SizedBox(height: 20),
          Text("Hello, $name!",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          SizedBox(height: 16),
          Text("Start Shopping",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800])),
          SizedBox(height: 16),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Search products...",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }



Widget _buildProductGrid() {

  
  if (_isLoading) {
    return Center(child: CircularProgressIndicator());
  }

  if (_products.isEmpty) {
    return Center(child: Text("No products found."));
  }

  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 4 / 6,
    ),
    itemCount: _products.length,
    itemBuilder: (context, index) {
      final product = _products[index];
      if (product == null) return Container();

      final String productId = product['_id'] ?? '';
      final String name = product['name'] ?? 'No Name';
      final int price = product['price'] ?? 0;

      Uint8List? imageBytes;
      if (product['itemImage'] != null && product['itemImage']['data'] != null) {
        imageBytes = Uint8List.fromList(List<int>.from(product['itemImage']['data']));
      }

      ValueNotifier<bool> isLiked = ValueNotifier(false);

      // Check if product is in wishlist
      wishlistService.getWishlist().then((wishlistData) {
        isLiked.value = wishlistData.any((item) => item['id'] == productId);
      });

      return GestureDetector(
        onTap: () {
          if (productId.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(productId: productId),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: imageBytes != null
                        ? Image.memory(
                            imageBytes,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 140,
                          )
                        : Container(
                            height: 140,
                            color: Colors.grey[200],
                            child: Icon(Icons.image, size: 50, color: Colors.grey),
                          ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: ValueListenableBuilder(
                      valueListenable: isLiked,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            if (value) {
                              // Remove from wishlist
                              wishlistService.removeFromWishlist(productId);
                            } else {
                              // Add to wishlist
                              wishlistService.addToWishlist(product);
                            }
                            isLiked.value = !value; // Toggle like state
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              value ? Icons.favorite : Icons.favorite_border,
                              color: value ? Colors.red : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
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
                    SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: AppColor.primary, 
                        ),
                        onPressed: () {
                          // Add to cart logic here
                        },
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}