import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Changepasswordrequest {
  String currentPassword;
  String newPassword;
  String confirmPassword;
  Changepasswordrequest({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }

  factory Changepasswordrequest.fromMap(Map<String, dynamic> map) {
    return Changepasswordrequest(
      currentPassword: map['currentPassword'] as String,
      newPassword: map['newPassword'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Changepasswordrequest.fromJson(String source) => Changepasswordrequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
