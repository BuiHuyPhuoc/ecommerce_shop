import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/ChangePasswordRequest.dart';
import 'package:ecommerce_shop/models/api_respond.dart';
import 'package:ecommerce_shop/models/register_customer.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> LoginWithEmailAndPassword(String email, String password) async {
  // Gọi api đăng nhập
  final url = 'https://10.0.2.2:7277/api/Auth/Login';
  final Dio _dio = Dio();
  try {
    final respond = await _dio.post(url,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}));
    if (respond.statusCode == 200) {
      // Lưu token
      String jwtToken = jsonEncode(respond.data['token']).replaceAll("\"", "");
      String jwtRefreshToken =
          jsonEncode(respond.data['refreshToken']).replaceAll("\"", "");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jwtToken);
      await prefs.setString('refreshToken', jwtRefreshToken);
      return true;
    } else {
      return false;
    }
  } on DioError catch (e) {
    print(e.message);
    return false;
  }
}

Future<bool> RequestNewToken() async {
  Dio _dio = Dio();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? rfsToken = await preferences.getString("refreshToken");

  if (rfsToken == null) {
    return false;
  } else {
    try {
      String encode = jsonEncode(rfsToken);
      var res = await _dio.post(
        "https://10.0.2.2:7277/api/Auth/RefreshToken",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: encode,
      );
      String jwtToken = res.data['token'];
      await preferences.setString('token', jwtToken);
      return true;
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }
}

void Logout(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove("token");
  preferences.remove("refreshToken");
  await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => SignInScreen()),
      (dynamic Route) => false);
}

Future<ApiRespond> SignUp(RegisterCustomer register) async {
  Dio _dio = Dio();
  final url = 'https://10.0.2.2:7277/api/Auth/Register';
  try {
    final respond = await _dio.post(
      url,
      data: register.toMap(),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (respond.statusCode == 200) {
      return new ApiRespond(
          statusCode: respond.statusCode!, message: respond.data);
    } else {
      return new ApiRespond(
          statusCode: respond.statusCode!, message: respond.data);
    }
  } on DioError catch (e) {
    if (e.response!.statusCode == 400) {
      return new ApiRespond(statusCode: e.hashCode, message: e.response!.data!);
    } else {
      return new ApiRespond(
          statusCode: e.hashCode, message: "Đã có lỗi xảy ra");
    }
  }
}

Future<void> SendNewVerifyEmail(String email) async {
  Dio _dio = Dio();
  final url = 'https://10.0.2.2:7277/api/Auth/SendNewVerifyEmail?email=$email';
  try {
    await _dio.post(
      url,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
  } on DioError catch (e) {
    print(e.message);
    throw Exception("Something went wrong");
  }
}

Future<bool> ChangePassword({required Changepasswordrequest request}) async {
  final url = 'https://10.0.2.2:7277/api/Auth/ChangePassword';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("token");
  if (token == null) {
    throw Exception("Sign in time out");
  }
  Dio _dio = Dio();
  try {
    final response = await _dio.post(
      url,
      data: {
        'currentPassword': request.currentPassword,
        'newPassword': request.newPassword,
        'confirmPassword': request.confirmPassword,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print(response.data);
    return true;
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      bool checkGetNewToken = await RequestNewToken();
      if (checkGetNewToken) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        token = preferences.getString("token");
        try {
          final response = await _dio.post(
            url,
            data: {
              'currentPassword': request.currentPassword,
              'newPassword': request.newPassword,
              'confirmPassword': request.confirmPassword,
            },
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            }),
          );
          print(response.data);
          return true;
        } on DioException catch (e) {
          print(e.response!.data);
          throw Exception(e.response!.data);
        }
      } else {
        throw Exception("Sign in time out");
      }
    } else {
      print(e.response!.data);
      throw Exception(e.response!.data);
    }
  }
}

Future<bool> ForgotPassword(String email) async {
  final url = 'https://10.0.2.2:7277/api/Auth/ForgotPassword/?email=${email}';
  Dio _dio = Dio();

  try {
    await _dio.post(url);
    return true;
  } on DioException catch (e) {
    if (e.response!.statusCode == 400) {
      throw Exception(e.message);
    } else {
      return false;
    }
  }
}
