import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/cart.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Cart>> GetCarts() async {
  List<Cart> carts = [];
  Dio _dio = Dio();
  var url = "https://10.0.2.2:7277/api/Cart/GetCart";
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("token");
  var _options = Options(
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  if (token == null) {
    throw Exception("Login time out");
  } else {
    try {
      var respond = await _dio.get(url, options: _options);
      List<dynamic> jsonData = respond.data;
      carts = jsonData.map((item) => Cart.fromMap(item)).toList();
      return carts;
    } on DioException catch (e) {
      print(e.message);
      if (e.response!.statusCode == 401) {
        bool checkGetNewToken = await RequestNewToken();
        if (checkGetNewToken) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          token = preferences.getString("token");
          _options = Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          );
          var respond = await _dio.get(url, options: _options);
          List<dynamic> jsonData = respond.data;
          carts = jsonData.map((item) => Cart.fromMap(item)).toList();
          return carts;
        } else {
          throw Exception("Sign in time out");
        }
      } else {
        throw Exception("Something went wrong. Please try again");
      }
    }
  }
}
