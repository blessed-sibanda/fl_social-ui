import 'package:http/http.dart';
import 'dart:convert';

class ServiceApiError {
  final String message;
  final int code;
  ServiceApiError(this.message, this.code);
}

abstract class BaseApi {
  String baseUrl = 'http://192.168.43.72:3000';

  Future<dynamic> jsonResponse(
    Response response, {
    String dataKey = '',
    String errorKey = 'error',
  }) async {
    var jsonResponse = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (dataKey.isNotEmpty) {
        return jsonResponse[dataKey];
      } else {
        return jsonResponse;
      }
    } else {
      return ServiceApiError(jsonResponse[errorKey], response.statusCode);
    }
  }
}
