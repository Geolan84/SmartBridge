import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/data_providers/session_data_provider.dart';
import 'dart:async';
import 'dart:io';

class ProfileRepository {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();


  Future<void> deleteProfile() async {
    var id = await _sessionDataProvider.getUserId();
    var token = await _sessionDataProvider.getToken();
    int userId = int.parse(id!);
    await _apiClient.deleteProfile(token!, userId);
  }

  Future<void> uploadImage(File file) async{
    var id = await _sessionDataProvider.getUserId();
    var token = await _sessionDataProvider.getToken();
    int userId = int.parse(id!);
    await _apiClient.uploadImage(file, token!, userId);
  }

}
