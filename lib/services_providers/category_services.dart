import 'package:punto_de_reunion/controllers/category_controller.dart';
import 'package:punto_de_reunion/models/category/es_categories.dart';
import 'package:punto_de_reunion/utils/struct_response.dart';

class CategoryServices {
  Future<EsCategories> getCategories() async {
    StructResponse serviceResponse = StructResponse();
    EsCategories esCategories = await CategoryController.getAll(5, 1);
    serviceResponse.response = esCategories;

    return esCategories;
  }
}
