import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Address {
  int? id;
  String receiverName;
  String receiverPhone;
  String city;
  String district;
  String ward;
  String street;
  bool isDefault;
  Address({
    this.id,
    required this.receiverName,
    required this.receiverPhone,
    required this.city,
    required this.district,
    required this.ward,
    required this.street,
    required this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'city': city,
      'district': district,
      'ward': ward,
      'street': street,
      'isDefault': isDefault,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int?,
      receiverName: map['receiverName'] as String,
      receiverPhone: map['receiverPhone'] as String,
      city: map['city'] as String,
      district: map['district'] as String,
      ward: map['ward'] as String,
      street: map['street'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);
}
