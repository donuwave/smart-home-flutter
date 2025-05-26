import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _storage = FlutterSecureStorage();

  static String? _accessToken;
  static int? _homeId;
  static int? _userId;

  static Future<void> init() async {
    _accessToken = await _storage.read(key: 'accessToken');

    final homeIdStr = await _storage.read(key: 'home_id');
    _homeId = int.tryParse(homeIdStr ?? '');

    final userIdStr = await _storage.read(key: 'user_id');
    _userId = int.tryParse(userIdStr ?? '');
  }

  static String? get accessTokenSync => _accessToken;
  static int? get homeIdSync => _homeId;
  static int? get userIdSync => _userId;

  static Future<void> saveTokens(
    String accessToken,
    String refreshToken,
    int userId,
  ) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
    await _storage.write(key: 'user_id', value: userId.toString());
    _accessToken = accessToken;
    _userId = userId;
  }

  static Future<void> setHomeId(int homeId) async {
    await _storage.write(key: 'home_id', value: homeId.toString());
    _homeId = homeId;
  }

  static Future<String?> getAccessToken() => _storage.read(key: 'accessToken');
  static Future<String?> getHomeId() => _storage.read(key: 'home_id');
  static Future<String?> getUserId() => _storage.read(key: 'user_id');

  static Future<void> clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
    await _storage.delete(key: 'user_id');
    await _storage.delete(key: 'home_id');
    _accessToken = null;
    _homeId = null;
    _userId = null;
  }
}
