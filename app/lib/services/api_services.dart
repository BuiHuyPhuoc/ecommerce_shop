import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_shop/services/auth_services.dart';

const String baseUrl = 'https://10.0.2.2:7277/api';

Future<Map<String, String>> BuildHeaders(
    {bool withAuthorization = false}) async {
  var _options = {
    'Content-Type': 'application/json',
  };
  if (withAuthorization == true) {
    String? token = await GetToken();
    _options.addAll({
      'Authorization': 'Bearer $token',
    });
  }
  return _options;
}

Future<T> ExecuteWithRetry<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioError catch (e) {
    if (e.response?.statusCode == 403) {
      throw TimeoutException("Unauthorized.");
    }
    if (e.response?.statusCode == 401) {
      bool tokenRefreshed = await RequestNewToken();
      if (tokenRefreshed) {
        return await request();
      } else {
        throw TimeoutException("Session expired. Please log in again.");
      }
    }
    throw Exception("API request failed: ${e.message}");
  }
}

class ApiRespond {
  int statusCode;
  String message;
  ApiRespond({
    required this.statusCode,
    required this.message,
  });
}
