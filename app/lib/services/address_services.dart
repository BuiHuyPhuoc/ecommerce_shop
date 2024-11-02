import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/address.dart';
import 'package:ecommerce_shop/services/auth_services.dart';

Future<List<Address>> GetAddress() async {
  List<Address> address = [];
  final url = 'https://10.0.2.2:7277/api/Address/GetAddress';
  String? token = await GetToken();
  Dio _dio = Dio();
  if (token == null) {
    throw Exception("Sign in time out");
  } else {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      List<dynamic> jsonData = response.data;
      address = jsonData.map((item) => Address.fromMap(item)).toList();
      return address;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        bool check = await RequestNewToken();
        if (check) {
          token = await GetToken();
          try {
            final response = await _dio.get(
              url,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
            );
            List<dynamic> jsonData = response.data;
            address = jsonData.map((item) => Address.fromMap(item)).toList();
            return address;
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
        throw Exception("Failed when get data");
      }
    }
  }
}
