// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_shop/models/brand.dart';
import 'package:ecommerce_shop/models/category.dart';
import 'package:ecommerce_shop/models/review.dart';

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
  List<Review> reviews;
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
    required this.reviews,
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
      'reviews': reviews
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
        idCategoryNavigation: Category.fromMap(
            map['idCategoryNavigation'] as Map<String, dynamic>),
        reviews: List<Review>.from(
            (map['reviews'] as List).map((item) => Review.fromMap(item))));
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductDetail {
  int id;
  String nameProduct;
  String description;
  double priceProduct;
  double? newPrice;
  String imageProduct;
  bool isValid;
  Brand idBrandNavigation;
  Category idCategoryNavigation;
  List<String> productImages;
  List<ProductVarient> productVarients;
  List<Review> reviews;
  ProductDetail({
    required this.id,
    required this.nameProduct,
    required this.description,
    required this.priceProduct,
    this.newPrice,
    required this.imageProduct,
    required this.isValid,
    required this.idBrandNavigation,
    required this.idCategoryNavigation,
    required this.productImages,
    required this.productVarients,
    required this.reviews,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'nameProduct': nameProduct,
  //     'description': description,
  //     'priceProduct': priceProduct,
  //     'newPrice': newPrice,
  //     'imageProduct': imageProduct,
  //     'isValid': isValid,
  //     'idBrandNavigation': idBrandNavigation.toMap(),
  //     'idCategoryNavigation': idCategoryNavigation.toMap(),
  //     'productImages': productImages,
  //     'productVarients': productVarients.map((x) => x.toMap()).toList(),
  //   };
  // }

  factory ProductDetail.fromMap(Map<String, dynamic> map) {
    return ProductDetail(
      id: map['id'] as int,
      nameProduct: map['nameProduct'] as String,
      description: map['description'] as String,
      priceProduct: map['priceProduct'] as double,
      newPrice: map['newPrice'] != null ? map['newPrice'] as double : null,
      imageProduct: map['imageProduct'] as String,
      isValid: map['isValid'] as bool,
      idBrandNavigation:
          Brand.fromMap(map['idBrandNavigation'] as Map<String, dynamic>),
      idCategoryNavigation:
          Category.fromMap(map['idCategoryNavigation'] as Map<String, dynamic>),
      productImages: List<String>.from((map['productImages'] as List)
          .map((item) => item['imageUrl'] as String)),
      productVarients: List<ProductVarient>.from(
        (map['productVarients'] as List).map(
          (x) => ProductVarient.fromMap(x),
        ),
      ),
      reviews: List<Review>.from(
          (map['reviews'] as List).map((item) => Review.fromMap(item))),
    );
  }

  // String toJson() => json.encode(toMap());

  factory ProductDetail.fromJson(String source) =>
      ProductDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductVarient {
  int id;
  int idProduct;
  int size;
  Product? idProductNavigation;
  bool isValid;
  ProductVarient({
    required this.id,
    required this.idProduct,
    required this.size,
    this.idProductNavigation,
    required this.isValid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idProduct': idProduct,
      'size': size,
      'idProductNavigation': idProductNavigation?.toMap(),
      'isValid': isValid,
    };
  }

  factory ProductVarient.fromMap(Map<String, dynamic> map) {
    return ProductVarient(
      id: map['id'] as int,
      idProduct: map['idProduct'] as int,
      size: map['size'] as int,
      idProductNavigation: map['idProductNavigation'] != null
          ? Product.fromMap(map['idProductNavigation'] as Map<String, dynamic>)
          : null,
      isValid: map['isValid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVarient.fromJson(String source) =>
      ProductVarient.fromMap(json.decode(source) as Map<String, dynamic>);
}
