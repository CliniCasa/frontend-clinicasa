import '../models/appointment.dart';
import 'api_service.dart';

class AppointmentService {
  // Verificar disponibilidade de horários
  static Future<List<String>> getAvailableSlots(
    String workerId,
    String date,
  ) async {
    try {
      final response = await ApiService.get(
        '/appointments/availability?workerId=$workerId&date=$date',
      );

      if (response.containsKey('data')) {
        final List<dynamic> slotsData = response['data'];
        return slotsData.map((slot) => slot.toString()).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Erro ao buscar horários disponíveis: $e');
    }
  }

  // Criar novo agendamento
  static Future<Appointment> createAppointment({
    required String workerId,
    required String userId,
    required DateTime date,
  }) async {
    try {
      final data = {
        'workerId': workerId,
        'userId': userId,
        'date': date.toIso8601String(),
      };

      final response = await ApiService.post('/appointments', data);
      return Appointment.fromJson(response);
    } catch (e) {
      throw Exception('Erro ao criar agendamento: $e');
    }
  }
}
