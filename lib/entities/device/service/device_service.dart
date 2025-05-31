import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:smart_home/entities/device/service/device_response.dart';
import 'package:smart_home/shared/config.dart';

class DeviceService {
  static final String baseUrl = AppConfig.apiUrl;

  Future<List<DeviceResponse>> getDeviceList() async {
    final accessToken = await TokenManager.getAccessToken();
    final homeId = await TokenManager.getHomeId();

    final response = await http.get(
      Uri.parse("$baseUrl/api/v1/device/home/$homeId"),
      headers: {
        'Authorization': 'Bearer $accessToken',
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
        .map((e) => DeviceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DeviceResponse> getDeviceById(deviceId) async {
    final accessToken = await TokenManager.getAccessToken();

    final response = await http.get(
      Uri.parse("$baseUrl/api/v1/device/$deviceId"),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Ошибка ${response.statusCode}: ${response.reasonPhrase}',
      );
    }

    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    return DeviceResponse.fromJson(decodedResponse);
  }
}
