import 'package:http/http.dart';
import 'dart:convert';

class ServiceApiError {
  final String message;
  final int code;
  ServiceApiError(this.message, this.code);
}

abstract class BaseApi {
  String baseUrl = 'http://192.168.43.72:3000';
  // String baseUrl = 'http://127.0.0.1:3000';

  Future<dynamic> jsonResponse(
    Response response, {
    String dataKey = '',
    String errorKey = 'error',
  }) async {
    final jsonResponse = json.decode(response.body);
    List<int> successCodes = [200, 201, 204];

    if (successCodes.contains(response.statusCode)) {
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
