import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/order.dart';
import 'package:ecommerce_shop/models/order_request.dart';
import 'package:ecommerce_shop/services/api_services.dart';

Future<bool> AddOrder(OrderRequest request) async {
  final Dio _dio = Dio();
  return await ExecuteWithRetry<bool>(
    () async {
      await _dio.post(
        '$baseUrl/Order/AddOrder',
        options: Options(headers: await BuildHeaders(withAuthorization: true)),
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
  return await ExecuteWithRetry<List<Order>>(
    () async {
      var response = await _dio.get(
        '$baseUrl/Order/GetOrder',
        options: Options(headers: await BuildHeaders(withAuthorization: true)),
      );
      return (response.data as List)
          .map((data) => Order.fromMap(data))
          .toList();
    },
  );
}

Future<Order> GetOrderDetail(int id) async {
  final Dio _dio = Dio();
  return await ExecuteWithRetry<Order>(
    () async {
      var response = await _dio.get(
        '$baseUrl/Order/GetOrderDetail?id=$id',
        options: Options(headers: await BuildHeaders(withAuthorization: true)),
      );
      var result = Order.fromMap(response.data);
      return (result);
    },
  );
}
