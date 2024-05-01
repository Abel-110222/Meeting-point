// ignore_for_file: non_constant_identifier_names

import 'package:punto_de_reunion/models/organization/organization_model.dart';
import 'package:punto_de_reunion/utils/en_info.dart';
import 'package:punto_de_reunion/utils/es_estructura.dart';

class EsOrganization extends EsEstructura {
  bool success = false;
  List<OrganizationModel>?organizations  = [];

  EsOrganization({
    this.success = false,
    this.organizations,

    ///!
    super.info,
  });
  factory EsOrganization.fromJson(Map<String, dynamic> json) => EsOrganization(
        success: json["success"] ?? false,
        organizations: json["organizations"] == null
            ? null
            : List<OrganizationModel>.from(json["organizations"].map((x) => OrganizationModel.fromJson(x))),

        ///
        info: json["info"] == null ? null : EnInfo.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "organizations": organizations,
        "info": info,
      };
}
