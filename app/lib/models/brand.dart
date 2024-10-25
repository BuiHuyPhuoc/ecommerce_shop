import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brand {
  int id;
  String nameBrand;
  Brand({
    required this.id,
    required this.nameBrand,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nameBrand': nameBrand,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] as int,
      nameBrand: map['nameBrand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source) as Map<String, dynamic>);
}
