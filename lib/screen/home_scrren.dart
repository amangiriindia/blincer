import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import '../constant/app_color.dart';
import '../constant/voice_to_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../service/weather_service.dart';
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

  @override
  void initState() {
    super.initState();
   // _getCurrentWeather('Bengaluru'); // Default city
  }

  void _showLocationModal() {
    showLocationModal(context);
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
        : Icon(Icons.cloud, color: Colors.white, size: 50), // Default cloud icon
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
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3 / 4,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network("https://via.placeholder.com/150",
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product ${index + 1}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("\$${(index + 1) * 10}",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
