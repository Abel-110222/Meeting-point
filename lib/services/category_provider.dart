import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:punto_de_reunion/models/categories_model.dart';

class CategoryServices {
  Future<List<Categories>> getCategories() async {
    final response =
        await http.get(Uri.parse('https://punto-de-reunion.vercel.app/api/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Categories> categoriesList = [];

      for (var item in jsonData[0]['categories']) {
        categoriesList.add(Categories.fromJson(item));
      }

      return categoriesList; // Devuelve la lista de categorías
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
