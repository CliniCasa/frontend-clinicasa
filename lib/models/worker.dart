import 'package:json_annotation/json_annotation.dart';

part 'worker.g.dart';

@JsonSerializable()
class Worker {
  final String id;
  final String name;
  final String email;
  final String role;

  Worker({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => _$WorkerFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerToJson(this);
}

enum WorkerRole {
  @JsonValue('Enfermeira')
  enfermeira,
  @JsonValue('Massagista')
  massagista,
  @JsonValue('Fisioterapeuta')
  fisioterapeuta,
  @JsonValue('Psicólogo')
  psicologo,
  @JsonValue('Outros')
  outros,
}
