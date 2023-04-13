import 'package:flutter/material.dart';
import 'package:smartbridge/domain/repositories/auth_repository.dart';
//import 'package:smartbridge/domain/data_providers/session_data_provider.dart';
import 'package:smartbridge/domain/models/resume.dart';


class ResumeViewModel extends ChangeNotifier{
  //final _sRepository = ResumeRepository();
  final _authRepository = AuthRepository();

  int resumeId = -1;
  //bool _isDownloadProgress = false;
  //bool get canStartShow => !_isDownloadProgress;
  Resume? resume;
  bool is_hr = false;
  Image avatar = Image.asset("assets/images/avatar.jpg");


  Future<void> initRole() async{
    is_hr = await _authRepository.isHr();
    notifyListeners();
  }

  Future<void> downloadPhoto(int userId) async{
    avatar = Image.network('http://10.0.2.2:8080/profile/photo/$userId');
    //_isDownloadProgress = false;
    notifyListeners();
  }


  ResumeViewModel(Resume? resumeParam){
    initRole();
    resume = resumeParam;
    if(resume != null){
      downloadPhoto(resume!.userID);
      notifyListeners();
    }
  }
}
