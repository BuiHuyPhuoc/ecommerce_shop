// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_shop/models/product.dart';

class OrderDetail {
  int idOrder;
  int idProduct;
  String productName;
  double productPrice;
  double? salePrice;
  int quantity;
  Product? idProductNavigation;
  OrderDetail({
    required this.idOrder,
    required this.idProduct,
    required this.productName,
    required this.productPrice,
    this.salePrice,
    required this.quantity,
    this.idProductNavigation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idOrder': idOrder,
      'idProduct': idProduct,
      'productName': productName,
      'productPrice': productPrice,
      'salePrice': salePrice,
      'quantity': quantity,
      'idProductNavigation': idProductNavigation?.toMap(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      idOrder: map['idOrder'] as int,
      idProduct: map['idProduct'] as int,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as double,
      salePrice: map['salePrice'] != null ? map['salePrice'] as double : null,
      quantity: map['quantity'] as int,
      idProductNavigation: map['idProductNavigation'] != null ? Product.fromMap(map['idProductNavigation'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) => OrderDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
