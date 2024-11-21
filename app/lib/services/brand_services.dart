import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/brand.dart';
import 'package:ecommerce_shop/services/api_services.dart';

Future<List<Brand>> GetAllBrand() async {
  Dio _dio = Dio();
  var respond = await _dio.get(
    '$baseUrl/Brand/GetAllBrand',
    options: Options(
      headers: await BuildHeaders(),
    ),
  );
  List<dynamic> data = respond.data;
  List<Brand> brands = [];
  brands = data.map((element) => Brand.fromMap(element)).toList();
  return brands;
}
