import 'package:flutter/material.dart';
import 'package:smartbridge/domain/repositories/resume_repository.dart';
import 'package:smartbridge/domain/models/resume.dart';


class ResumeViewModel extends ChangeNotifier{
  //final _resumeRepository = ResumeRepository();

  int resumeId = -1;
  bool _isDownloadProgress = false;
  bool get canStartShow => !_isDownloadProgress;
  Resume? resume;

  // ResumeViewModel(int resumeIdParam){
  //   resumeId = resumeIdParam;
  //   print("New resume id:");
  //   print(resumeId);
  //   initValues();
  // }

  ResumeViewModel(Resume? resumeParam){
    resume = resumeParam;
    if(resume != null){
      notifyListeners();
      //initValues();
    }
  }

  // Future<void> initValues() async{
  //   // if(resumeId != -1){
  //   //   _isDownloadProgress = true;
  //   //   resume = await _resumeRepository.getResumeById(resumeId);
  //   //   _isDownloadProgress = false;
  //   //   notifyListeners();
  //   // }
  // }
}
