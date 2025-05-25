import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveTokens(
    String accessToken,
    String refreshToken,
    int userId,
  ) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
    await _storage.write(key: "user_id", value: userId.toString());
  }

  static Future<void> saveHomeId(int homeId) async {
    await _storage.write(key: 'home_id', value: homeId.toString());
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: "user_id");
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  static Future<String?> getHomeId() async {
    return await _storage.read(key: 'home_id');
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
    await _storage.delete(key: 'user_id');
    await _storage.delete(key: 'home_id');
  }
}
