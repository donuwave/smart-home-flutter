import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:smart_home/entities/home/service/home_response.dart';
import 'package:smart_home/shared/config.dart';

class HomeService {
  static final String baseUrl = AppConfig.apiUrl;

  Future<List<HomeResponse>> getHomeList() async {
    final accessToken = await TokenManager.getAccessToken();
    final response = await http.post(
      Uri.parse("$baseUrl/api/v1/home/accessible"),
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

    final List<dynamic> rawList = jsonDecode(response.body) as List<dynamic>;

    return rawList
        .map((e) => HomeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<HomeResponse> getHomeById(id) async {
    final accessToken = await TokenManager.getAccessToken();

    final response = await http.get(
      Uri.parse("$baseUrl/api/v1/home/$id"),
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
    return HomeResponse.fromJson(decodedResponse);
  }
}
