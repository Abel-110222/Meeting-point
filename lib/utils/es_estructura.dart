import 'package:punto_de_reunion/utils/en_info.dart';

class EsEstructura {
  EnInfo? info;

  EsEstructura({this.info});

  factory EsEstructura.fromJson(Map<String, dynamic> json) => EsEstructura(
        info: EnInfo.fromJson(json["info"]),
      );
}
