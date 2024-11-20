import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce_shop/class/const.dart';
import 'package:ecommerce_shop/models/order.dart';
import 'package:ecommerce_shop/models/order_request.dart';
import 'package:ecommerce_shop/services/auth_services.dart';

Future<Map<String, String>> _buildHeaders(
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

Future<T> _executeWithRetry<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioError catch (e) {
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

Future<bool> AddOrder(OrderRequest request) async {
  final Dio _dio = Dio();
  return await _executeWithRetry<bool>(
    () async {
      await _dio.post(
        '$baseUrl/Order/AddOrder',
        options: Options(headers: await _buildHeaders(withAuthorization: true)),
        data: jsonEncode(
          request.toMap(),
        ),
      );
      return true;
    },
  );
}

Future<List<Order>> GetOrder() async {
  final Dio _dio = Dio();
  return await _executeWithRetry<List<Order>>(
    () async {
      var response = await _dio.get(
        '$baseUrl/Order/GetOrder',
        options: Options(headers: await _buildHeaders(withAuthorization: true)),
      );
      return (response.data as List)
          .map((data) => Order.fromMap(data))
          .toList();
    },
  );
}

Future<Order> GetOrderDetail(int id) async {
  final Dio _dio = Dio();
  return await _executeWithRetry<Order>(
    () async {
      var response = await _dio.get(
        '$baseUrl/Order/GetOrderDetail?id=$id',
        options: Options(headers: await _buildHeaders(withAuthorization: true)),
      );
      var result = Order.fromMap(response.data);
      return (result);
    },
  );
}
