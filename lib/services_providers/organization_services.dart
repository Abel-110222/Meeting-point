import 'package:punto_de_reunion/controllers/organization_controller.dart';
import 'package:punto_de_reunion/models/organization/es_organization.dart';
import 'package:punto_de_reunion/utils/struct_response.dart';

class OrganizationService {
  Future<EsOrganization> getOrganizations() async {
    StructResponse serviceResponse = StructResponse();
    EsOrganization esOrganization = await OrganizationController.getAll(5, 1);
    serviceResponse.response = esOrganization;

    return esOrganization;
  }
}
