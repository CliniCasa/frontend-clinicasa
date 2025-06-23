// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
  worker: Worker.fromJson(json['worker'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'worker': instance.worker,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.scheduled: 'SCHEDULED',
  AppointmentStatus.completed: 'COMPLETED',
  AppointmentStatus.cancelled: 'CANCELLED',
};
