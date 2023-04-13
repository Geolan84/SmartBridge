import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/data_providers/session_data_provider.dart';
import 'package:smartbridge/domain/models/template.dart';


class MessageRepository {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<List<Template>> getTemplates() async {
    var token = await _sessionDataProvider.getToken();
    var res = await _apiClient.getTemplates(token!);
    return res;
  }

  Future<void> addNewTemplate(String title, String body) async {
    var token = await _sessionDataProvider.getToken();
    _apiClient.addNewTemplate(token!, title, body);
  }

  Future<void> deleteTemplate(int templateId) async {
    try{
    var token = await _sessionDataProvider.getToken();
    _apiClient.deleteTemplate(token!, templateId);
    } catch(_){
      
    }
  }


}