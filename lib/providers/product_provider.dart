import 'package:flutter/material.dart';
import 'package:punto_de_reunion/models/product/es_product.dart';
import 'package:punto_de_reunion/services_providers/Product_services.dart';

class ProductProvider extends ChangeNotifier {
  late EsProduct categories;

  Future<EsProduct> getCategories() async {
    var services = ProductServices();
    categories = await services.getProducts();

    notifyListeners();
    return categories;
  }

   Future<EsProduct> refreshCategories() async {
    var services = ProductServices();
    categories = (await services.getProducts());

    notifyListeners();
    return categories;
  }
}
