// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomerDTO {
  String email;
  String name;
  String phone;
  int idRole;
  String nameRole;
  String avatarImageUrl;
  
  CustomerDTO({
    required this.email,
    required this.name,
    required this.phone,
    required this.nameRole,
    required this.idRole,
    required this.avatarImageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'phone': phone,
      'nameRole': nameRole,
      'idRole': idRole,
      'avatarImageUrl': avatarImageUrl,
    };
  }

  factory CustomerDTO.fromMap(Map<String, dynamic> map) {
    return CustomerDTO(
      email: map['email'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      nameRole: map['nameRole'] as String,
      avatarImageUrl: map['avatarImageUrl'] as String,
      idRole: map['idRole'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerDTO.fromJson(String source) =>
      CustomerDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
