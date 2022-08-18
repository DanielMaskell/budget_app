import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;

  User(this.id);

  factory User.fromJson(Map<String, dynamic> json) => _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);

  @override
  String toString() => 'Id<$id>';
}

User _userFromJson(Map<String, dynamic> json) {
  return User(json['id'] as String);
}

Map<String, dynamic> _userToJson(User instance) =>
    <String, dynamic>{'id': instance.id};
