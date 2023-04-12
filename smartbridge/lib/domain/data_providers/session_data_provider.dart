import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const jwtKey = 'token';
  static const role = 'is_hr';
  static const userId = 'user_id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _Keys.jwtKey);
  }

  Future<String?> getRole() async{
    return await _secureStorage.read(key: _Keys.role);
  }

  Future<String?> getUserId() async{
    return await _secureStorage.read(key: _Keys.userId);
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _Keys.jwtKey, value: token);
  }

  Future<void> saveRole(String role) async{
    await _secureStorage.write(key: _Keys.role, value: role);
  }

  Future<void> saveUserId(String id) async{
    await _secureStorage.write(key: _Keys.userId, value: id);
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: _Keys.jwtKey);
  }

  Future<void> clearUserId() async {
    await _secureStorage.delete(key: _Keys.userId);
  }

  Future<void> clearRole() async {
    await _secureStorage.delete(key: _Keys.role);
  }
}