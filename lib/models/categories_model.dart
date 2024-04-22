import 'dart:convert';
import 'package:http/http.dart' as http;

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  String id;
  String name;
  String imageUrl;
  int totalProducts;
  DateTime createdAt;
  DateTime updatedAt;

  Categories({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.totalProducts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        totalProducts: json["totalProducts"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "totalProducts": totalProducts,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

Future<List<Categories>> fetchCategories() async {
  const url = 'http://punto-de-reunion.vercel.app/api/categories';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.body.isNotEmpty) {
      final jsonData = json.decode(response.body)['categories'];
      List<Categories> categoriesList = [];

      for (var item in jsonData) {
        categoriesList.add(Categories.fromJson(item));
      }

      return categoriesList;
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load categories: $e');
  }
}
