import 'package:smartbridge/domain/screen_factory.dart';
import 'package:smartbridge/domain/models/resume.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const forgot = '/forgot';
  static const register = '/register';
  static const mainScreen = '/main_screen';
  static const hrMainScreen = '/hr_main_screen';
  static const hrProfileSettings = '/hr_main_screen/profile';
  static const userProfileSettings = '/main_screen/profile';
  static const userAddResume = 'main_screen/add_resume';
  static const userResumeView = '/main_screen/resume';
  static const hrResumeView = '/hr_main_screen/resume';
  static const hrResumeList = '/hr_main_screen/resume_list';
  static const hrAddTemplate = '/hr_main_screen/add_template';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationRouteNames.forgot: (_) => _screenFactory.makeForgot(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
    MainNavigationRouteNames.hrMainScreen: (_) =>
        _screenFactory.makeHRMainScreen(),
    MainNavigationRouteNames.register: (_) => _screenFactory.makeRegister(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.hrProfileSettings:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeProfile(),
        );
      case MainNavigationRouteNames.userProfileSettings:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeProfile(),
        );
      case MainNavigationRouteNames.userAddResume:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeAddResume(),
        );
      case MainNavigationRouteNames.hrAddTemplate:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeAddTemplate(),
        );
      case MainNavigationRouteNames.userResumeView:
        final arguments = settings.arguments;
        final resume = arguments is Resume ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeResumeView(resume),
        );
      case MainNavigationRouteNames.hrResumeList:
        final arguments = settings.arguments;
        final resume = arguments is List<Resume> ? arguments : List<Resume>.empty();
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeResumesListHr(resume),
        );
      case MainNavigationRouteNames.hrResumeView:
        final arguments = settings.arguments;
        final resume = arguments is Resume ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeResumeView(resume),
        );
      
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loaderWidget,
      (route) => false,
    );
  }
}
