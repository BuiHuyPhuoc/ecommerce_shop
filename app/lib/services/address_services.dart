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
    throw TimeoutException("Sign in time out");
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

Future<bool> AddAddress(Address address) async {
  final url = 'https://10.0.2.2:7277/api/Address/AddAddress';
  String? token = await GetToken();
  Dio _dio = Dio();
  var _data = {
    "receiverName": address.receiverName,
    "receiverPhone": address.receiverPhone,
    "city": address.city,
    "district": address.district,
    "ward": address.ward,
    "street": address.street
  };
  if (token == null) {
    throw TimeoutException("Sign in time out");
  } else {
    try {
      await _dio.post(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ),
          data: _data);
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        bool check = await RequestNewToken();
        if (check) {
          token = await GetToken();
          if (token == null) {
            throw TimeoutException("Sign in time out");
          }
          try {
            await _dio.post(url,
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                    'Content-Type': 'application/json'
                  },
                ),
                data: _data);
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
        throw Exception("Failed when get data");
      }
    }
  }
}

Future<bool> UpdateAddress(Address address) async {
  final url = 'https://10.0.2.2:7277/api/Address/UpdateAddress/${address.id}';
  String? token = await GetToken();
  Dio _dio = Dio();
  var _data = {
    "receiverName": address.receiverName,
    "receiverPhone": address.receiverPhone,
    "city": address.city,
    "district": address.district,
    "ward": address.ward,
    "street": address.street
  };
  if (token == null) {
    throw TimeoutException("Sign in time out");
  } else {
    try {
      await _dio.put(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ),
          data: _data);
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        bool check = await RequestNewToken();
        if (check) {
          token = await GetToken();
          if (token == null) {
            throw TimeoutException("Sign in time out");
          }
          try {
            await _dio.put(url,
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                    'Content-Type': 'application/json'
                  },
                ),
                data: _data);
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
        throw Exception("Failed when get data");
      }
    }
  }
}

Future<bool> DeleteAddress(int idAddress) async {
  final url = 'https://10.0.2.2:7277/api/Address/DeleteAddress?id=$idAddress';
  String? token = await GetToken();
  Dio _dio = Dio();
  if (token == null) {
    throw TimeoutException("Sign in time out");
  } else {
    try {
      await _dio.delete(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ));
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        bool check = await RequestNewToken();
        if (check) {
          token = await GetToken();
          if (token == null) {
            throw TimeoutException("Sign in time out");
          }
          try {
            await _dio.delete(url,
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                    'Content-Type': 'application/json'
                  },
                ));
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
        throw Exception("Failed when get data");
      }
    }
  }
}

Future<bool> SetDefaultAddress(int id) async {
  final url = 'https://10.0.2.2:7277/api/Address/SetDefaultAddress/${id}';
  String? token = await GetToken();
  Dio _dio = Dio();
  if (token == null) {
    throw TimeoutException("Sign in time out");
  } else {
    try {
      await _dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        bool check = await RequestNewToken();
        if (check) {
          token = await GetToken();
          if (token == null) {
            throw TimeoutException("Sign in time out");
          }
          try {
            await _dio.put(
              url,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json'
                },
              ),
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
        throw Exception("Failed when get data");
      }
    }
  }
}
