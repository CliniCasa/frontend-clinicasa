// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String?,
  name: json['name'] as String,
  gender: json['gender'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  accountType: json['accountType'] as String,
  addressId: (json['addressId'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'gender': instance.gender,
  'phone': instance.phone,
  'email': instance.email,
  'password': instance.password,
  'accountType': instance.accountType,
  'addressId': instance.addressId,
};
