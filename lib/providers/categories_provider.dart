import 'package:flutter/material.dart';
import 'package:punto_de_reunion/models/category/es_categories.dart';
import 'package:punto_de_reunion/services_providers/category_services.dart';

class CategoriesProvider extends ChangeNotifier {
  late EsCategories categories;

  Future<EsCategories> getCategories() async {
    var services = CategoryServices();
    categories = await services.getCategories();

    notifyListeners();
    return categories;
  }

   Future<EsCategories> refreshCategories() async {
    var services = CategoryServices();
    categories = (await services.getCategories());

    notifyListeners();
    return categories;
  }
}
