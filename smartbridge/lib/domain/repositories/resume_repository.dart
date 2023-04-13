import 'package:smartbridge/domain/models/resume.dart';
import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/data_providers/session_data_provider.dart';

class ResumeRepository {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<List<Resume>> getResumes() async {
    var token = await _sessionDataProvider.getToken();
    var res = await _apiClient.getResumes(token!);
    return res;
  }

  Future<List<Resume>> getFavoriteResumes() async{
    var token = await _sessionDataProvider.getToken();
    var res = await _apiClient.getFavorites(token!);
    return res;
  }

  Future<List<Resume>> searchResumes() async{
    var token = await _sessionDataProvider.getToken();
    var res = await _apiClient.searchResumes(token!);
    return res;
  }

  Future<void> addNewResume(Resume newResume) async {
    var token = await _sessionDataProvider.getToken();
    _apiClient.addNewResume(token!, newResume.toJson());
  }

  Future<Resume?> getResumeById(int resumeId) async {
    var token = await _sessionDataProvider.getToken();
    Resume? result;
    try{
      result = await _apiClient.getResumeById(resumeId, token!);
    } catch(_){
      //print(e);
    }
    return result;
  }
}
