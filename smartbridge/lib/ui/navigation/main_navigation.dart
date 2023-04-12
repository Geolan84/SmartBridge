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
  //static const userResumeList = 'main'
  //static const movieDetails = '/main_screen/movie_details';
  //static const movieTrailerWidget = '/main_screen/movie_details/trailer';
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
      case MainNavigationRouteNames.userResumeView:
        final arguments = settings.arguments;
        //final resumeId = arguments is int ? arguments : 0;
        final resume = arguments is Resume ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeResumeView(resume),
        );
      case MainNavigationRouteNames.hrResumeView:
        final arguments = settings.arguments;
        final resume = arguments is Resume ? arguments : null;
        //final resumeId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          //builder: (_) => _screenFactory.makeResumeView(resumeId),
          builder: (_) => _screenFactory.makeResumeView(resume),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);

      // case MainNavigationRouteNames.movieDetails:
      //   final arguments = settings.arguments;
      //   final movieId = arguments is int ? arguments : 0;
      //   return MaterialPageRoute(
      //     builder: (_) => _screenFactory.makeMovieDetails(movieId),
      //   );
      // case MainNavigationRouteNames.movieTrailerWidget:
      //   final arguments = settings.arguments;
      //   final youtubeKey = arguments is String ? arguments : '';
      //   return MaterialPageRoute(
      //     builder: (_) => _screenFactory.makeMovieTrailer(youtubeKey),
      //   );
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loaderWidget,
      (route) => false,
    );
  }
}
