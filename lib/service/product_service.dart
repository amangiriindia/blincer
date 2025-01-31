import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant/app_constant.dart';

class ProductService {
  final String baseUrl = "${AppConstant.LOCAL_API_URL}/api/v1/product";

  Future<List<dynamic>> fetchProducts(String category) async {
    final url = Uri.parse('$baseUrl/all-product/$category');
    try {
      final response = await http.get(url);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
           
          return data['getAllProducts'];
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchSingleProduct(String productId) async {
    final response = await http.get(Uri.parse(
        '${AppConstant.LOCAL_API_URL}/api/v1/product/single-product/$productId'));
     print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return data['getSingleProduct'];
      } else {
        throw Exception('Failed to fetch product details: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch product details.');
    }
  }
}
