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
import 'package:smartbridge/domain/models/resume.dart';

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

  // Widget makeMovieDetails(int movieId) {
  //   return old_provider.NotifierProvider(
  //     create: () => MovieDetailsModel(movieId),
  //     child: const MovieDetailsWidget(),
  //   );
  // }

  // Widget makeMovieTrailer(String youtubeKey) {
  //   return MovieTrailerWidget(youtubeKey: youtubeKey);
  // }
}
