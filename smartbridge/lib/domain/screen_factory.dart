import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbridge/ui/widgets/welcome_screen/welcome_view_model.dart';
import 'package:smartbridge/ui/widgets/welcome_screen/welcome_widget.dart';
import 'package:smartbridge/ui/widgets/login/login_view_model.dart';
import 'package:smartbridge/ui/widgets/login/login_widget.dart';
import 'package:smartbridge/ui/widgets/main_screen/home_widget.dart';
import 'package:smartbridge/ui/widgets/main_screen/hr_home_widget.dart';
import 'package:smartbridge/ui/widgets/settings/settings.dart';
import 'package:smartbridge/ui/widgets/forgot/forgot_widget.dart';
import 'package:smartbridge/ui/widgets/forgot/forgot_view_model.dart';
import 'package:smartbridge/ui/widgets/registration/register_view_model.dart';
import 'package:smartbridge/ui/widgets/registration/register_widget.dart';
import 'package:smartbridge/ui/widgets/profile_changer/profile_view_model.dart';
import 'package:smartbridge/ui/widgets/profile_changer/profile_widget.dart';
import 'package:smartbridge/ui/widgets/add_resume/add_resume_view_model.dart';
import 'package:smartbridge/ui/widgets/add_resume/add_resume_widget.dart';
import 'package:smartbridge/ui/widgets/resume_list/resume_list_widget.dart';
import 'package:smartbridge/ui/widgets/settings/settings_view_model.dart';
import 'package:smartbridge/ui/widgets/resume_viewer/resume_view_model.dart';
import 'package:smartbridge/ui/widgets/resume_viewer/resume_widget.dart';
import 'package:smartbridge/ui/widgets/message_templates/message_template_widget.dart';
import 'package:smartbridge/ui/widgets/hr_search/hr_search_widget.dart';
import 'package:smartbridge/ui/widgets/hr_search/hr_search_view_model.dart';
import 'package:smartbridge/ui/widgets/add_template/add_template_view_model.dart';
import 'package:smartbridge/ui/widgets/add_template/add_template_widget.dart';
import 'package:smartbridge/ui/widgets/favorite_resumes/favorite_widget.dart';
import 'package:smartbridge/domain/models/resume.dart';
import 'package:smartbridge/ui/widgets/hr_resume_list/hr_resume_list_view_model.dart';
import 'package:smartbridge/ui/widgets/hr_resume_list/hr_resume_list_widget.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => WelcomeViewModel(context),
      lazy: false,
      child: const WelcomeWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeProfile() {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: const ProfileWidget(),
    );
  }

  Widget makeResumeList() {
    return const ResumeList();
    // return ChangeNotifierProvider(
    //   create: (_) => ResumeListViewModel(),
    //   child: const ResumeList(),
    // );
  }

  Widget makeSearchResume(){
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: const SearchWidget(),
    );
  }

  Widget makeResumesListHr(List<Resume> resumes){
    return ChangeNotifierProvider(
      create: (_) => ResumeListHRViewModel(resumes),
      child: const HrResumeListWidget(),
    );
  }

  Widget makeFavorite(){
    return const FavoriteResumeList();
  }

  Widget makeAddTemplate(){
    return ChangeNotifierProvider(
      create: (_) => AddTemplateViewModel(),
      child: const AddTemplateWidget(),
    );
  }

  Widget makeTemplatesList(){
    return const MessageTemplateWidget();
  }

  Widget makeAddResume() {
    return ChangeNotifierProvider(
      create: (_) => AddResumeViewModel(),
      child: const AddResumeWidget(),
    );
  }

  Widget makeForgot() {
    return ChangeNotifierProvider(
      create: (_) => ForgotViewModel(),
      child: const ForgotWidget(),
    );
  }

  Widget makeRegister() {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const RegisterWidget(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeResumeView(Resume? resume) {
    return ChangeNotifierProvider(
      create: (_) => ResumeViewModel(resume),
      child: const ResumeWidget(),
    );
  }

  Widget makeHRMainScreen() {
    return const HRMainScreenWidget();
  }

  Widget makeSettings() {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      child: const SettingsPage(),
    );
  }

}
