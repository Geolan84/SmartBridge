import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/data_providers/session_data_provider.dart';

class AuthRepository {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final token = await _sessionDataProvider.getToken();
    final isAuth = token != null;
    return isAuth;
  }

  Future<bool> isHr() async {
    final role = await _sessionDataProvider.getRole();
    return role != null && role == "true";
  }

  Future<void> resetPassword(String login) async {
    await _apiClient.resetPassword(login);
  }

  Future<void> login(String login, String password) async {
    final result = await _apiClient.auth(email: login, password: password);
    await _sessionDataProvider.saveToken(result["token"]);
    await _sessionDataProvider.saveRole(result["is_hr"]);
    await _sessionDataProvider.saveUserId(result["user_id"]);
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearToken();
    await _sessionDataProvider.clearRole();
    await _sessionDataProvider.clearUserId();
  }

  Future<void> register(
      String email,
      String password,
      String firstName,
      String secondName,
      String? patronymic,
      DateTime birthday,
      bool isHR) async {
    await _apiClient.register(
        email, password, firstName, secondName, patronymic, birthday, isHR);
  }
}
