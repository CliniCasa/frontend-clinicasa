import 'package:json_annotation/json_annotation.dart';
import 'worker.dart';
import 'user.dart';

part 'appointment.g.dart';

enum AppointmentStatus {
  @JsonValue('SCHEDULED')
  scheduled,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('CANCELLED')
  cancelled,
}

@JsonSerializable()
class Appointment {
  final String id;
  final DateTime date;
  final AppointmentStatus status;
  final Worker worker;
  final DateTime createdAt;

  Appointment({
    required this.id,
    required this.date,
    required this.status,
    required this.worker,
    required this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
