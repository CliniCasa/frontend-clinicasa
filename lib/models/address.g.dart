// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  id: (json['id'] as num?)?.toInt(),
  street: json['street'] as String,
  number: json['number'] as String,
  neighborhood: json['neighborhood'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  zipcode: json['zipcode'] as String,
  complement: json['complement'] as String?,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'street': instance.street,
  'number': instance.number,
  'neighborhood': instance.neighborhood,
  'city': instance.city,
  'state': instance.state,
  'zipcode': instance.zipcode,
  'complement': instance.complement,
};
