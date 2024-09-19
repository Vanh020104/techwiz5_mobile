import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/cart_item.dart';

class CartService {
  final String baseUrl = 'http://10.0.2.2:8080';

  CartService();

  Future<void> addToCart(CartItem cartItem) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$baseUrl/api/v1/cart');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(cartItem.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add to cart');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}