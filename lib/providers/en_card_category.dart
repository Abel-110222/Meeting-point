import 'package:flutter/material.dart';
import 'package:punto_de_reunion/models/categories_model.dart';
import 'package:punto_de_reunion/services/category_provider.dart';

class CategoriesProvider extends ChangeNotifier {
  late List<Categories> categories;

  Future<List<Categories>> getCategories() async {
    var services = CategoryServices();
    categories = await services.getCategories();

    notifyListeners();
    return categories;
  }

  Future<List<Categories>> refreshCategories() async {
    var services = CategoryServices();
    categories = (await services.getCategories()).cast<Categories>();

    notifyListeners();
    return categories;
  }
}
