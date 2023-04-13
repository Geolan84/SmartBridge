import 'package:flutter/material.dart';
import 'package:smartbridge/domain/repositories/resume_repository.dart';
import 'package:smartbridge/domain/models/resume.dart';


class ResumeListHRViewModel extends ChangeNotifier{
  //final _resumeRepository = ResumeRepository();

  int resumeId = -1;
  bool _isDownloadProgress = false;
  bool get canStartShow => !_isDownloadProgress;
  List<Resume> resume = List.empty();

  ResumeListHRViewModel(List<Resume> resumeParam){
    resume = resumeParam;
    //if(resume != null){
    notifyListeners();
    //}
  }
}
