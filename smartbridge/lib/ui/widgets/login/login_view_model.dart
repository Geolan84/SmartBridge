import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/repositories/auth_repository.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/utils.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthRepository();

  final TextEditingController emailTextInputController =
      TextEditingController();
  final TextEditingController passwordTextInputController =
      TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  BuildContext? _context;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<String?> _login(String login, String password) async {
    try {
      await _authService.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return LocaleSwitcher.of(_context!)!.networkerror;
          //return 'Сервер не доступен. Проверте подключение к интернету';
        case ApiClientExceptionType.auth:
          return LocaleSwitcher.of(_context!)!.noauth;
          //return 'Неправильный логин пароль!';
        case ApiClientExceptionType.noAnswer:
          return LocaleSwitcher.of(_context!)!.noanswer;
          //return 'Сервер не отвечает!';
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
        return LocaleSwitcher.of(_context!)!.defaulterror;
          //return 'Произошла ошибка. Попробуйте еще раз';
      }
    } catch (e) {
      return LocaleSwitcher.of(_context!)!.defaulterror;
      //return 'Неизвестная ошибка, поторите попытку';
    }
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = emailTextInputController.text;
    final password = passwordTextInputController.text;

    //if (validateEmail(login) && validatePassword(password)) {}

    if (!validateEmail(login) || !validatePassword(password)) {
      _updateState(LocaleSwitcher.of(context)!.noauth, false);
      return;
    }
    _context = context;
    _updateState(null, true);
    //Try to auth.
    _errorMessage = await _login(login, password);
    if (_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
