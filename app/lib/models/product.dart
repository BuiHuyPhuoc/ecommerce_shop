// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:ecommerce_shop/models/brand.dart';
import 'package:ecommerce_shop/models/category.dart';

class Product {
  int id;
  String nameProduct;
  String description;
  double priceProduct;
  double? newPrice;
  String imageProduct;
  bool isValid;
  Brand idBrandNavigation;
  Category idCategoryNavigation;
  Product({
    required this.id,
    required this.nameProduct,
    required this.description,
    required this.priceProduct,
    required this.newPrice,
    required this.imageProduct,
    required this.isValid,
    required this.idBrandNavigation,
    required this.idCategoryNavigation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nameProduct': nameProduct,
      'description': description,
      'priceProduct': priceProduct,
      'newPrice': newPrice,
      'imageProduct': imageProduct,
      'isValid': isValid,
      'idBrandNavigation': idBrandNavigation.toMap(),
      'idCategoryNavigation': idCategoryNavigation.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      nameProduct: map['nameProduct'] as String,
      description: map['description'] as String,
      priceProduct: map['priceProduct'] as double,
      newPrice: map['newPrice'] as double,
      imageProduct: map['imageProduct'] as String,
      isValid: map['isValid'] as bool,
      idBrandNavigation:
          Brand.fromMap(map['idBrandNavigation'] as Map<String, dynamic>),
      idCategoryNavigation:
          Category.fromMap(map['idCategoryNavigation'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
