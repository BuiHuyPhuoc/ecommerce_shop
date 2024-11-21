import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/category.dart';
import 'package:ecommerce_shop/services/api_services.dart';

Future<List<Category>> GetAllCategory() async {
  Dio _dio = Dio();
  var respond = await _dio.get(
    '$baseUrl/Category/GetAllCategory',
    options: Options(
      headers: await BuildHeaders(),
    ),
  );
  List<dynamic> data = respond.data;
  List<Category> categories = [];
  categories = data.map((element) => Category.fromMap(element)).toList();
  return categories;
}
