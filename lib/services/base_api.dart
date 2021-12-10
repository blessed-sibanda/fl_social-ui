import 'package:fl_social/utils/app_cache.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ServiceApiError {
  final String message;
  final int code;
  ServiceApiError(this.message, this.code);
}

abstract class BaseApi {
  String baseUrl = 'http://192.168.43.72:3000';
  final appCache = AppCache();

  Future<String> get authToken async {
    return await appCache.userToken();
  }

  dynamic jsonResponse(
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
