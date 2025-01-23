import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://192.168.1.20:8080";

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/v1/user/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      // Log the response for debugging
      print("Response Body: ${response.body}");
      print("Status Code: ${response.statusCode}");

      // Parse the response body
      final data = json.decode(response.body);

      // Handle HTTP status codes
      if (response.statusCode == 200) {
        return data; // Successful response
      } else if (response.statusCode == 400) {
        return data;
      } else {
        throw Exception(data['message']); // Pass error message to exception
      }
    } catch (e) {
      // Handle any exceptions that may occur
      throw Exception("Error: ${e.toString()}");
    }
  }
}
