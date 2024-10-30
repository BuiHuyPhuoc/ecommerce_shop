// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_shop/models/product.dart';

class Cart {
  int id;
  ProductVarient idProductVarientNavigation;
  int quantity;
  Cart({
    required this.id,
    required this.idProductVarientNavigation,
    required this.quantity,
  });
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idProductVarientNavigation': idProductVarientNavigation.toMap(),
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as int,
      idProductVarientNavigation: ProductVarient.fromMap(map['idProductVarientNavigation'] as Map<String,dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}
