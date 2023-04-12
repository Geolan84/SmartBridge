//import 'package:provider/provider.dart';
import 'package:smartbridge/domain/repositories/resume_repository.dart';
import 'package:smartbridge/domain/models/resume.dart';
import 'package:flutter/material.dart';

class ResumeListViewModel extends ChangeNotifier {
  final _resumeService = ResumeRepository();
  var resumes = <Resume>[];

}