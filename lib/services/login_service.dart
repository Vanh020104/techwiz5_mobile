import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/v1/auth/login';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

   if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['accessToken'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', token);
      }
      return responseBody;
    } else {
      throw Exception('');
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }

}