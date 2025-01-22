import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '3b423f0ebb7a41e783f155546252201'; // Your API key.
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse('$baseUrl?key=$apiKey&q=$city&aqi=no');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch weather data: ${response.reasonPhrase}');
    }
  }
}
