import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/order.dart';
import 'package:ecommerce_shop/models/order_request.dart';
import 'package:ecommerce_shop/services/auth_services.dart';

Future<bool> AddOrder(OrderRequest request) async {
  final url = 'https://10.0.2.2:7277/api/Order/AddOrder';
  final _data = jsonEncode(request.toMap());
  String? token = await GetToken();
  Dio _dio = Dio();
  if (token == null) {
    throw TimeoutException("Sign in time out");
  } else {
    var _options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    try {
      await _dio.post(
        url,
        options: _options,
        data: _data,
      );
      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        bool check = await RequestNewToken();
        if (check) {
          token = await GetToken();
          try {
            await _dio.post(
              url,
              options: _options,
              data: _data,
            );
            return true;
          } on DioError catch (e) {
            if (e.response!.statusCode == 401) {
              throw TimeoutException("Login time out");
            } else {
              throw Exception(e.response!.data);
            }
          }
        } else {
          throw TimeoutException("Login time out");
        }
      } else {
        throw Exception("Failed when create order");
      }
    }
  }
}

Future<List<Order>> GetOrder() async {
  final url = 'https://10.0.2.2:7277/api/Order/GetOrder';
  String? token = await GetToken();
  Dio _dio = Dio();
  if (token == null) {
    throw TimeoutException("Sign in time out");
  } else {
    var _options = Options(headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    try {
      var response = await _dio.get(
        url,
        options: _options,
      );
      List<dynamic> data = response.data;
      List<Order> listOrders = [];
      listOrders = data.map((item) => Order.fromMap(item)).toList();
      return listOrders;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        bool check = await RequestNewToken();
        if (check) {
          token = await GetToken();
          _options = Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
          try {
            var response = await _dio.get(
              url,
              options: _options,
            );
            List<dynamic> data = response.data;
            List<Order> listOrders =
                data.map((item) => Order.fromMap(item)).toList();
            return listOrders;
          } on DioError catch (e) {
            if (e.response!.statusCode == 401) {
              throw TimeoutException("Login time out");
            } else {
              throw Exception(e.response!.data);
            }
          }
        } else {
          throw TimeoutException("Login time out");
        }
      } else {
        throw Exception("Failed when get order");
      }
    }
  }
}
