import 'package:frontend_clinicasa/models/user.dart';
import 'package:frontend_clinicasa/models/address.dart';
import 'api_service.dart';
import 'dart:convert';

class RegisterService {
  // Retorna true se sucesso, lança Exception se erro
  static Future<void> registerUser({
    required User user,
    required Address address,
  }) async {
    try {
      // Cria o payload conforme esperado pelo backend
      final payload = {
        'name': user.name,
        'gender': user.gender,
        'phone': user.phone,
        'email': user.email,
        'password': user.password,
        'accountType': user.accountType,
        'address': {
          'street': address.street,
          'number': address.number,
          'neighborhood': address.neighborhood,
          'city': address.city,
          'state': address.state,
          'zipcode': address.zipcode,
          'complement': address.complement,
        },
      };

      // Faz a requisição POST para /users com o endereço aninhado
      final response = await ApiService.post('/users', payload);

      if (response['id'] == null) {
        throw Exception('Usuário não foi criado corretamente');
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('400')) {
        // Verifica se é erro de email duplicado
        if (e.toString().contains('email') ||
            e.toString().contains('duplicate')) {
          throw Exception('EMAIL_DUPLICADO');
        }
        throw Exception('Dados inválidos fornecidos');
      } else if (e is Exception && e.toString().contains('409')) {
        // Conflito - geralmente email duplicado
        throw Exception('EMAIL_DUPLICADO');
      } else if (e is Exception && e.toString().contains('422')) {
        // Erro de validação
        throw Exception('Dados inválidos fornecidos');
      }
      rethrow;
    }
  }
}
