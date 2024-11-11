import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderRequest {
  List<int> idCarts;
  String status;
  int idAddress;
  OrderRequest({
    required this.idCarts,
    required this.status,
    required this.idAddress,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCarts': idCarts,
      'status': status,
      'idAddress': idAddress,
    };
  }

  factory OrderRequest.fromMap(Map<String, dynamic> map) {
    return OrderRequest(
      idCarts: List<int>.from(map['idCarts'] as List<int>),
      status: map['status'] as String,
      idAddress: map['idAddress'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderRequest.fromJson(String source) => OrderRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
