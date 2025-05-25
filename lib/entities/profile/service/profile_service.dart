import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:smart_home/entities/profile/service/profile_response.dart';
import 'package:smart_home/shared/config.dart';

class ProfileService {
  static final String baseUrl = AppConfig.apiUrl;

  Future<ProfileResponse> getProfile() async {
    final userId = await TokenManager.getUserId();
    final accessToken = await TokenManager.getAccessToken();

    final response = await http.get(
      Uri.parse("$baseUrl/api/v1/profile/$userId"),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Ошибка ${response.statusCode}: ${response.reasonPhrase}',
      );
    }

    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    return ProfileResponse.fromJson(decodedResponse);
  }
}
