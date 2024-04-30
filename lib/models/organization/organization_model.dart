class OrganizationModel {
  String? id;
  String? name;
  String? imageUrl;
  String? description;
  bool deliveryAllowed;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;


  OrganizationModel({
    this.id,
    this.name,
    this.imageUrl,
    this.description = '',
    this.deliveryAllowed = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.deletedAt = '',
  });
  factory OrganizationModel.fromJson(Map<String, dynamic> json) => OrganizationModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        description: json["description"] ?? '',
        deliveryAllowed: json["deliveryAllowed"] ?? false,
        createdAt: json["createdAt"] ?? DateTime.now().toString(),
        updatedAt: json["updatedAt"] ?? DateTime.now().toString(),
        deletedAt: json["deletedAt"] ?? DateTime.now().toString(),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
        "deliveryAllowed": deliveryAllowed,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
      };
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// List<Categories> categoriesFromJson(String str) =>
//     List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

// String categoriesToJson(List<Categories> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Categories {
//   String? id;
//   String? name;
//   String? imageUrl;
//   int totalProducts;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Categories({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.totalProducts,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Categories.fromJson(Map<String, dynamic> json) {
//     try {
//       return Categories(
//         id: json["id"] ?? "",
//         name: json["name"] ?? "",
//         imageUrl: json["imageUrl"] ?? "",
//         totalProducts: int.parse(json["totalProducts"] ?? "0"),
//         createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
//         updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
//       );
//     } catch (e) {
//       print("Error parsing category: $e");
//       return Categories(
//         id: "",
//         name: "",
//         imageUrl: "",
//         totalProducts: 0,
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//     }
//   }

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "imageUrl": imageUrl,
//         "totalProducts": totalProducts,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//       };
// }

// Future<List<Categories>> fetchCategories() async {
//   const url = 'http://punto-de-reunion.vercel.app/api/categories';

//   try {
//     final response = await http.get(Uri.parse(url));

//     if (response.body.isNotEmpty) {
//       final jsonData = json.decode(response.body)['categories'];
//       List<Categories> categoriesList = [];

//       for (var item in jsonData) {
//         categoriesList.add(Categories.fromJson(item));
//       }

//       return categoriesList;
//     } else {
//       throw Exception('Failed to load categories: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Failed to load categories: $e');
//   }
// }
