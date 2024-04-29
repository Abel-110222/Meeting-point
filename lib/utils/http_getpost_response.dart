import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:punto_de_reunion/utils/default_struct_http_response.dart';

/// Realiza una solicitud HTTP GET o POST y devuelve una estructura de respuesta predeterminada.
///
/// `request` puede ser 'GET' o 'POST'.
/// `service` es el nombre del servicio al que se está haciendo la solicitud.
/// `url` es el Uri de la solicitud.
/// `body` es el cuerpo de la solicitud POST.
/// `showResult` indica si se deben mostrar los detalles de la respuesta en modo de depuración.
Future<DefaultStructHttpResponse> httpGetPostResponse(
  String request,
  String service,
  Uri url,
  Object body,
  int currentPage,
  int limit, [
  bool showResult = false,
]) async {
  url = url.replace(queryParameters: {
    'currentPage': currentPage.toString(),
    'limit': limit.toString(),
  });
  // Configurar cabeceras
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
    'Accept': '*/*'
  };

  // Crear estructura de respuesta predeterminada
  DefaultStructHttpResponse defaultStruct = DefaultStructHttpResponse();

  try {
    // Realizar la solicitud HTTP
    http.Response? response;
    if (request == 'GET') {
      response = await http.get(url);
    } else if (request == 'POST') {
      response = await http.post(
        url,
        headers: headers,
        body: body,
      );
    }

    // Mostrar detalles de la respuesta en modo de depuración
    if (kDebugMode && showResult) {
      if (kDebugMode) {
        print('----response.ini: $url\n');
        print(response!.body);

        print('\n----response.end');
      }
    }

    // Verificar el código de estado HTTP
    if (response!.statusCode == 200) {
      defaultStruct.body = response.body;
      defaultStruct.success = true;
    } else {
      // Registrar el código de estado HTTP si no es 200
      defaultStruct.message = 'Error en $service: Código de estado HTTP ${response.statusCode}';
      defaultStruct.success = false;
    }
  } catch (ex) {
    // Manejar errores de red u otros errores
    defaultStruct.success = false;
    defaultStruct.message = "Error en $service: ${ex.toString()}";
  }

  return defaultStruct;
}
