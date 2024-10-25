import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/api_respond.dart';
import 'package:ecommerce_shop/models/register_customer.dart';
import 'package:ecommerce_shop/widgets/login_check_screen.dart';
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
      String jwtToken = respond.data['token'];
      String jwtRefreshToken = respond.data['refreshToken'];

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
      var res = await _dio.get(
        "https://10.0.2.2:7277/api/Auth/RefreshToken",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: rfsToken,
      );
      if (res.statusCode == 200) {
        String jwtToken = res.data['token'];

        await preferences.setString('token', jwtToken);
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e.message);
      return false;
    }
  }
}

Future<void> Logout(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove("token");
  preferences.remove("refreshToken");
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => LoginCheckScreen()),
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
