import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterCustomer {
  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;
  RegisterCustomer({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory RegisterCustomer.fromMap(Map<String, dynamic> map) {
    return RegisterCustomer(
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterCustomer.fromJson(String source) => RegisterCustomer.fromMap(json.decode(source) as Map<String, dynamic>);
}
