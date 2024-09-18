import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/category.dart';

class CategoryService {
  final String apiUrl = 'http://10.0.2.2:8082/api/v1/categories/getAll';

  Future<List<Category>> fetchCategories({int page = 1, int limit = 50}) async {
    final response = await http.get(Uri.parse('$apiUrl?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> content = body['data']['content'];
      List<Category> categories = content.map((dynamic item) => Category.fromJson(item)).toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}