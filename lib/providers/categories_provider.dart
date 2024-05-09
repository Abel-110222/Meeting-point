import 'package:flutter/material.dart';
import 'package:punto_de_reunion/models/category/categories_model.dart';
import 'package:punto_de_reunion/models/category/es_categories.dart';
import 'package:punto_de_reunion/services_providers/category_services.dart';

class CategoriesProvider extends ChangeNotifier {
  late EsCategories categories = EsCategories();
  late List<Categories> _categoriesList = [];


  Future<EsCategories> getCategories() async {
    if (categories.categories != null && categories.categories!.isNotEmpty) {
      return categories;
    }
    var services = CategoryServices();
    categories = await services.getCategories();

    _categoriesList = categories.categories!;

    notifyListeners();
    return categories;
  }

   Future<EsCategories> refreshCategories() async {
    var services = CategoryServices();
    categories = (await services.getCategories());

    notifyListeners();
    return categories;
  }
  List<Categories> get category => _categoriesList;
}
