import 'package:flutter/material.dart';
import 'package:punto_de_reunion/models/organization/es_organization.dart';
import 'package:punto_de_reunion/services_providers/organization_services.dart';

class OrganizationsProvider extends ChangeNotifier {
  late EsOrganization _organizations;

  Future<EsOrganization> getOrganizations() async {
    var service = OrganizationService();
    _organizations = await service.getOrganizations();

    notifyListeners();
    return _organizations;
  }

  Future<EsOrganization> refreshOrganizations() async {
    var service = OrganizationService();
    _organizations = await service.getOrganizations();

    notifyListeners();
    return _organizations;
  }
}
