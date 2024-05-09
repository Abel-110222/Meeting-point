import 'package:flutter/material.dart';
import 'package:punto_de_reunion/models/product/Product_Model.dart';
import 'package:punto_de_reunion/models/product/es_product.dart';
import 'package:punto_de_reunion/services_providers/Product_services.dart';

class ProductProvider extends ChangeNotifier {
  late EsProduct product = EsProduct();
  late List<ProductModel> _productList = [];

  Future<EsProduct> getProducts() async {
    if (product.products != null && product.products!.isNotEmpty) {
      return product;
    }
    var services = ProductServices();
    product = await services.getProducts();
    _productList = product.products!;

    notifyListeners();
    return product;
  }

  List<ProductModel> get productList => _productList;

  Future<EsProduct> refreshCategories() async {
    var services = ProductServices();
    product = (await services.getProducts());

    notifyListeners();
    return product;
  }
}
