// ignore_for_file: file_names

import 'package:punto_de_reunion/controllers/product_controller.dart';
import 'package:punto_de_reunion/models/product/es_product.dart';
import 'package:punto_de_reunion/utils/struct_response.dart';

class ProductServices {
  Future<EsProduct> getProducts() async {
    StructResponse serviceResponse = StructResponse();
    EsProduct esCategories = await ProductController.getAll(5, 1);
    serviceResponse.response = esCategories;

    return esCategories;
  }
}
