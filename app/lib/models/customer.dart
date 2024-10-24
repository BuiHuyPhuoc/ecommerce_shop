import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Customer {
  int Id;
  String Name;
  String Phone;
  int IdRole;
  String AvatarImageUrl;
  Customer({
    required this.Id,
    required this.Name,
    required this.Phone,
    required this.IdRole,
    required this.AvatarImageUrl
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Name': Name,
      'Phone': Phone,
      'IdRole': IdRole,
      'AvatarImageUrl': AvatarImageUrl,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      Id: map['Id'] as int,
      Name: map['Name'] as String,
      Phone: map['Phone'] as String,
      IdRole: map['IdRole'] as int,
      AvatarImageUrl: map['AvatarImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}
