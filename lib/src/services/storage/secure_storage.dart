import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const accessTokenKey = "accessToken";
  static const refreshTokenKey = "refreshToken";
  static void save(String key, String? data) {
    if (data != null) {
      final storage = FlutterSecureStorage();
      storage.write(key: key, value: data);
    }
  }

  static Future<String?> read(String key) async {
    final storage = FlutterSecureStorage();
    return storage.read(key: key);
  }
}
