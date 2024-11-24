// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_shop/models/customer.dart';

class Review {
  int rating;
  String content;
  DateTime date;
  Customer idCustomerNavigation;
  Review({
    required this.rating,
    required this.content,
    required this.date,
    required this.idCustomerNavigation,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'content': content,
      'date': date.millisecondsSinceEpoch,
      'idCustomerNavigation': idCustomerNavigation.toMap(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: map['rating'] as int,
      content: map['content'] as String,
      date: DateTime.parse(map['date'] as String),
      idCustomerNavigation: Customer.fromMap(map['idCustomerNavigation'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
