import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;
  static const _accessKey = 'ACCESS_TOKEN';

  SecureStorage([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessKey, value: token);
  Future<String?> readAccessToken() => _storage.read(key: _accessKey);
  Future<void> clear() => _storage.delete(key: _accessKey);
}
