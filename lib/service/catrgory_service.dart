import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/app_constant.dart';

class CategoryService {
  final String baseUrl =
      "http://192.168.1.20:8080/api/v1/category/all-category"; // Replace with your actual API base URL

  Future<List<dynamic>> getAllCategories() async {
    final url = Uri.parse('${AppConstant.LOCAL_API_URL}/api/v1/category/all-category');
    try {
      final response = await http.get(url);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return data['category'];
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
