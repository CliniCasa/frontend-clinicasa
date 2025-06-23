// Rode o comando abaixo para gerar o arquivo user.g.dart:
// flutter pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? id;
  final String name;
  final String gender;
  final String phone;
  final String email;
  final String password;
  final String accountType;
  final int? addressId;

  User({
    this.id,
    required this.name,
    required this.gender,
    required this.phone,
    required this.email,
    required this.password,
    required this.accountType,
    this.addressId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
