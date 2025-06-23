import '../models/worker.dart';
import 'api_service.dart';

class WorkerService {
  // Buscar todos os funcionários
  static Future<List<Worker>> getWorkers({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    try {
      String endpoint = '/workers?page=$page&limit=$limit';
      if (search != null && search.isNotEmpty) {
        endpoint += '&search=$search';
      }

      final response = await ApiService.get(endpoint);

      if (response.containsKey('data')) {
        final List<dynamic> workersData = response['data'];
        return workersData.map((json) => Worker.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Erro ao buscar funcionários: $e');
    }
  }

  // Buscar funcionário por ID
  static Future<Worker> getWorkerById(String id) async {
    try {
      final response = await ApiService.get('/workers/$id');
      return Worker.fromJson(response);
    } catch (e) {
      throw Exception('Erro ao buscar funcionário: $e');
    }
  }

  // Criar novo funcionário
  static Future<Worker> createWorker({
    required String name,
    required String email,
    required String role,
  }) async {
    try {
      final data = {'name': name, 'email': email, 'role': role};

      final response = await ApiService.post('/workers', data);
      return Worker.fromJson(response);
    } catch (e) {
      throw Exception('Erro ao criar funcionário: $e');
    }
  }

  // Atualizar funcionário
  static Future<Worker> updateWorker({
    required String id,
    String? name,
    String? email,
    String? role,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (role != null) data['role'] = role;

      final response = await ApiService.patch('/workers/$id', data);
      return Worker.fromJson(response);
    } catch (e) {
      throw Exception('Erro ao atualizar funcionário: $e');
    }
  }

  // Deletar funcionário
  static Future<void> deleteWorker(String id) async {
    try {
      await ApiService.delete('/workers/$id');
    } catch (e) {
      throw Exception('Erro ao deletar funcionário: $e');
    }
  }
}
