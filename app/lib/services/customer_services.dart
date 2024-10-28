import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/customer.dart';
import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/services/storage/storage_service.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Customer?> GetCustomerByJwtToken() async {
  final url = 'https://10.0.2.2:7277/api/Customer/GetCustomerByJwtToken';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("token");
  if (token == null) {
    return null;
  } else {
    Dio _dio = Dio();
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        // Phản hồi thành công
        Customer dbCustomer = Customer.fromMap(response.data);
        return dbCustomer;
      } else {
        return null;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        bool checkGetNewToken = await RequestNewToken();
        if (checkGetNewToken) {
          token = preferences.getString("token");
          final response = await _dio.get(
            url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          );
          if (response.statusCode == 200) {
            // Phản hồi thành công
            Customer dbCustomer = Customer.fromMap(response.data);
            return dbCustomer;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        print('Failed request: ${e.message}');
        return null;
      }
    }
  }
}

Future<CustomerDTO?> GetCustomerDTOByJwtToken() async {
  final url = 'https://10.0.2.2:7277/api/Customer/GetCustomer';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("token");
  if (token == null) {
    return null;
  } else {
    Dio _dio = Dio();
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      CustomerDTO dbCustomer = CustomerDTO.fromMap(response.data);
      return dbCustomer;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        bool checkGetNewToken = await RequestNewToken();
        if (checkGetNewToken) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          token = preferences.getString("token");
          try {
            final response = await _dio.get(
              url,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
            );
            CustomerDTO dbCustomer = CustomerDTO.fromMap(response.data);
            return dbCustomer;
          } catch (e) {
            print(e);
            return null;
          }
        } else {
          return null;
        }
      } else {
        print('Failed request: ${e.message}');
        return null;
      }
    }
  }
}

void UpdateProfile(BuildContext context, String name, String phone) async {
  LoadingDialog(context);
  final url = 'https://10.0.2.2:7277/api/Customer/UpdateCustomer';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("token");
  if (token == null) {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        (MaterialPageRoute(builder: (builder) => SignInScreen())),
        (dynamic Route) => false);
  } else {
    Dio _dio = Dio();
    try {
      await _dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "name": name,
          "phone": phone,
        },
      );
      SuccessToast(context: context, message: "Update successfully",).ShowToast();
      Navigator.pop(context);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        bool checkGetNewToken = await RequestNewToken();
        if (checkGetNewToken) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          token = preferences.getString("token");
          await _dio.put(
            url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
            data: {
              "name": name,
              "phone": phone,
            },
          );
          SuccessToast(context: context, message: "Update successfully",).ShowToast();
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              (MaterialPageRoute(builder: (builder) => SignInScreen())),
              (dynamic Route) => false);
        }
      } else if (e.response!.statusCode == 400) {
        String respond = e.response!.data;
        Navigator.pop(context);
        WarningToast(context: context, message: respond).ShowToast();
      } else {
        print('Failed request: ${e.message}');
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            (MaterialPageRoute(builder: (builder) => SignInScreen())),
            (dynamic Route) => false);
      }
    }
  }
}

Future<void> UpdateAvatar(BuildContext context) async {
  LoadingDialog(context);
  final url = 'https://10.0.2.2:7277/api/Customer/UpdateAvatar';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("token");
  if (token == null) {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        (MaterialPageRoute(builder: (builder) => SignInScreen())),
        (dynamic Route) => false);
  } else {
    Dio _dio = Dio();
    String? urlImage = await StorageService().uploadImage();
    if (urlImage == null) {
      Navigator.pop(context);
      return;
    }
    var _data = jsonEncode(urlImage);
    var _options = Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    try {
      await _dio.post(
        url,
        options: _options,
        data: _data,
      );
      Navigator.pop(context);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        bool checkGetNewToken = await RequestNewToken();
        if (checkGetNewToken) {
          token = preferences.getString("token");
          _options = Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          );
          await _dio.post(
            url,
            options: _options,
            data: _data,
          );
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              (MaterialPageRoute(builder: (builder) => SignInScreen())),
              (dynamic Route) => false);
        }
      } else if (e.response!.statusCode == 400) {
        Navigator.pop(context);
        WarningToast(context: context, message: "Lỗi").ShowToast();
      } else {
        print('Failed request: ${e.message}');
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            (MaterialPageRoute(builder: (builder) => SignInScreen())),
            (dynamic Route) => false);
      }
    }
  }
}
