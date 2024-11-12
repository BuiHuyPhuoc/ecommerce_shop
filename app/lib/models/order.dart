// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_shop/models/address.dart';
import 'package:ecommerce_shop/models/order_detail.dart';

class Order {
  int id;
  DateTime date;
  int idCustomer;
  Address idAddressNavigation;
  String status;
  double amount;
  List<OrderDetail>? orderDetails;
  Order({
    required this.id,
    required this.date,
    required this.idCustomer,
    required this.idAddressNavigation,
    required this.status,
    required this.amount,
    required this.orderDetails,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'date': date.millisecondsSinceEpoch,
  //     'idCustomer': idCustomer,
  //     'idAddressNavigation': idAddressNavigation.toMap(),
  //     'status': status,
  //     'amount': amount,
  //     'orderDetails': (orderDetails != null) ? orderDetails!.map((x) => x.toMap()).toList() : null,
  //   };
  // }

  // factory Order.fromMap(Map<String, dynamic> map) {
  //   return Order(
  //     id: map['id'] as int,
  //     date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
  //     idCustomer: map['idCustomer'] as int,
  //     idAddressNavigation: Address.fromMap(map['idAddressNavigation'] as Map<String,dynamic>),
  //     status: map['status'] as String,
  //     amount: map['amount'] as double,
  //     orderDetails: List<OrderDetail>.from((map['orderDetails'] as List<OrderDetail>).map<OrderDetail>((x) => OrderDetail.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'idCustomer': idCustomer,
      'idAddressNavigation': idAddressNavigation.toMap(),
      'status': status,
      'amount': amount,
      'orderDetails': (orderDetails != null) ? orderDetails!.map((x) => x.toMap()).toList() : null,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      date: DateTime.parse(map['date'] as String),
      idCustomer: map['idCustomer'] as int,
      idAddressNavigation: Address.fromMap(map['idAddressNavigation'] as Map<String,dynamic>),
      status: map['status'] as String,
      amount: map['amount'] as double,
      orderDetails: map['orderDetails'] != null ? List<OrderDetail>.from((map['orderDetails'] as List<dynamic>).map<OrderDetail?>((x) => OrderDetail.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
