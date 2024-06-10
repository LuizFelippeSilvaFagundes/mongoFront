import 'package:http/http.dart' as http;
import 'dart:convert';

class PsicologoService {

  final PsicologoService psicologoService = PsicologoService();
  Future<List<Map<String, dynamic>>> fetchPsychologistUsers(String psychologistEmail) async {
    final String url = 'http://localhost:1000/psychologist_users/$psychologistEmail';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Falha ao carregar usuários do psicólogo');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}

