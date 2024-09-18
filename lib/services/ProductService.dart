import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class ProductService {
  final String apiUrl = 'http://10.0.2.2:8080/api/v1/products/getAll';

  Future<List<Product>> fetchProducts(int page, int limit) async {
    final response = await http.get(Uri.parse('$apiUrl?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> productsJson = data['data']['content'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}