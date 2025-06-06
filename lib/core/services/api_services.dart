import 'dart:convert';
import 'package:easy_shop/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "https://fakestoreapi.com/products";

  static Future<List<Product>> fetchProduct() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
