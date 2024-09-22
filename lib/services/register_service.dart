import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  static const String _registerUrl = 'https://techwiz5-user-service-hbereff9dmexc6er.eastasia-01.azurewebsites.net/api/v1/auth/register';

  Future<Map<String, dynamic>> register(String username, String email, String password, String phoneNumber) async {
    final response = await http.post(
      Uri.parse(_registerUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password, 'phoneNumber': phoneNumber}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      throw Exception('Register failed!');
    }
  }
}