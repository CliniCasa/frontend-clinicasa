import '../models/appointment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AppointmentService {
  // Verificar disponibilidade de horários
  static Future<List<String>> getAvailableSlots(
    String workerId,
    String date,
  ) async {
    final url = Uri.parse(
      '${ApiService.baseUrl}/appointments/availability?workerId=$workerId&date=$date',
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }

  // Criar novo agendamento
  static Future<Appointment> createAppointment({
    required String workerId,
    required String userId,
    required DateTime date,
    required String service,
  }) async {
    try {
      final data = {
        'workerId': workerId,
        'userId': int.parse(userId),
        'date': date.toIso8601String(),
        'service': service,
      };

      print('Dados do agendamento: $data'); // Debug

      final response = await ApiService.post('/appointments', data);
      print('Resposta do servidor: $response'); // Debug

      return Appointment.fromJson(response);
    } catch (e) {
      print('Erro ao criar agendamento: $e'); // Debug
      throw Exception('Erro ao criar agendamento: $e');
    }
  }
}
