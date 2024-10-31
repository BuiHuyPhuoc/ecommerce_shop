import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/product.dart';

Future<List<Product>> GetProduct() async {
  List<Product> result = [];
  Dio _dio = Dio();
  try {
    var res = await _dio.get(
      "https://10.0.2.2:7277/api/Product/GetAllProduct",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    List<dynamic> jsonData = res.data;
    result = jsonData.map((item) => Product.fromMap(item)).toList();
    return result;
  } on DioError catch (e) {
    print(e.message);
    throw Exception("Eror when get product.");
  }
}

Future<List<Product>> GetSaleProduct() async {
  List<Product> result = [];
  Dio _dio = Dio();
  try {
    var res = await _dio.get(
      "https://10.0.2.2:7277/api/Product/GetSaleProduct",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    List<dynamic> jsonData = res.data;
    result = jsonData.map((item) => Product.fromMap(item)).toList();
    return result;
  } on DioError catch (e) {
    print(e.message);
    throw Exception("Eror when get product.");
  }
}

Future<ProductDetail> GetProductDetail(int id) async {
  ProductDetail result;
  Dio _dio = Dio();
  try {
    var res = await _dio.get(
      "https://10.0.2.2:7277/api/Product/GetProductById?id=${id}",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    result = ProductDetail.fromMap(res.data);
    return result;
  } on DioError catch (e) {
    print(e.message);
    throw Exception("Error when get product.");
  }
}
