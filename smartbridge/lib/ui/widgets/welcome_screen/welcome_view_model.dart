import 'package:smartbridge/domain/repositories/auth_repository.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class WelcomeViewModel {
  final BuildContext context;
  final _authService = AuthRepository();

  WelcomeViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    // Здесь будет редирект на страницу HR!
    final isAuth = await _authService.isAuth();
    final String nextScreen;
    if(isAuth){
      final isHr = await _authService.isHr();
      // print("IS HR: ");
      // print(isHr);
      if(isHr){
        nextScreen = MainNavigationRouteNames.hrMainScreen;
      } else{
        nextScreen = MainNavigationRouteNames.mainScreen;
      }
    } else{
      nextScreen = MainNavigationRouteNames.auth;
    }
    goToNextScreen(nextScreen);
  }

  void goToNextScreen(String nextScreen){
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}