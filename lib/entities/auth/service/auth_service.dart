import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_home/shared/config.dart';
import 'package:smart_home/entities/auth/widgets/auth_form/view.dart';

class AuthService {
  static final String baseUrl = AppConfig.apiUrl;

  Future<AuthResponse> login(String login, String password) async {
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
      final Map<String, dynamic> decodedResponse = json.decode(response.body);
      return AuthResponse.fromJson(decodedResponse);
    } else {
      throw Exception('Ошибка авторизации: ${response.statusCode}');
    }
  }

  Future<AuthResponse> register(String email, String password) async {
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
