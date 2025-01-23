import 'package:shared_preferences/shared_preferences.dart';

class UserConstant {
  static String? ID;
  static String? NAME;
  static String? EMAIL;
  static String? PHONE_NUMBER;
  static String? TOKEN;

  static Future<void> saveUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    ID = data['_id'];
    NAME = data['name'];
    EMAIL = data['email'];
    PHONE_NUMBER = data['phone'];
    TOKEN = data['token'];

    // Save to SharedPreferences
    prefs.setString('id', ID!);
    prefs.setString('name', NAME!);
    prefs.setString('email', EMAIL!);
    prefs.setString('phone', PHONE_NUMBER!);
    prefs.setString('token', TOKEN!);
  }

  static Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    ID = prefs.getString('id');
    NAME = prefs.getString('name');
    EMAIL = prefs.getString('email');
    PHONE_NUMBER = prefs.getString('phone');
    TOKEN = prefs.getString('token');
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // id = null;
    // name = null;
    // email = null;
    // phone = null;
    // token = null;
  }
}
