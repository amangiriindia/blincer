import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/user_constant.dart';

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

    final data = json.decode(response.body);

    if (response.statusCode == 200 && data['success']) {
      await UserConstant.saveUserData({
        '_id': data['loginAdmin']['_id'],
        'name': data['loginAdmin']['name'],
        'email': data['loginAdmin']['email'],
        'phone': data['loginAdmin']['phone'],
        'token': data['token'],
      });
      return data;
    } else if (response.statusCode == 400) {
      return data;
    } else {
      throw Exception(data['message']);
    }
  } catch (e) {
    throw Exception("Error: ${e.toString()}");
  }
}



  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/v1/user/create-profile');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
        }),
      );

// Log the response for debugging
      print("Response Body: ${response.body}");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 201) {
        return {"success": true, "message": "User registered successfully!"};
      } else {
        final data = jsonDecode(response.body);
        return {
          "success": false,
          "message": data['message'] ?? "Registration failed"
        };
      }
    } catch (e) {
      return {"success": false, "message": "An error occurred: $e"};
    }
  }


}
