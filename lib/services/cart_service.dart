
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/cart_item.dart';

class CartService {
  final String baseUrl = 'http://10.0.2.2:8080';

  CartService();

  // Thêm sản phẩm vào giỏ hàng
  Future<void> addToCart(CartItem cartItem) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Không tìm thấy token');
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
      throw Exception('Thêm sản phẩm vào giỏ hàng thất bại');
    }
  }

  // Lấy token từ SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Lấy dữ liệu giỏ hàng
  Future<List<Map<String, dynamic>>> getCartData(int userId) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Không tìm thấy token');
    }

    final url = Uri.parse('$baseUrl/api/v1/cart/user/$userId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];

    
      return data.map((item) {
        return {
          'productId': item['id']['productId'], 
          'userId': item['id']['userId'],      
          'quantity': item['quantity'],
          'unitPrice': item['unitPrice'],
          'productName': item['productName'],
          'productPrice': item['productPrice'],
          'description': item['description'],
          'status': item['status'],
          'productImages': item['productImages'], 
        };
      }).toList();
    } else {
      throw Exception('Không thể tải dữ liệu giỏ hàng');
    }
  }
}
