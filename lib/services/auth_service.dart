import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_home/config.dart';

class AuthService {
  static final String baseUrl = AppConfig.apiUrl;

  Future<Map<String, dynamic>> login(String login, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': login,
        'password': password,
        'device_id': "ffff",
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Успешный ответ
    } else {
      throw Exception('Ошибка авторизации: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body); // Успешная регистрация
    } else {
      throw Exception('Ошибка регистрации: ${response.statusCode}');
    }
  }
}
