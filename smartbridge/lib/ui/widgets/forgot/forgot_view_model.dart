import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/repositories/auth_repository.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:smartbridge/ui/utils.dart';
import 'package:flutter/material.dart';

class ForgotViewModel extends ChangeNotifier {
  final _authService = AuthRepository();
  

  final TextEditingController emailTextInputController =
      TextEditingController();

  String? _errorMessage;
  BuildContext? _context;
  String? get errorMessage => _errorMessage;

  Future<String?> _resetPassword(String login) async {
    try {
      await _authService.resetPassword(login);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return LocaleSwitcher.of(_context!)!.networkerror;
          //return 'Сервер не доступен. Проверте подключение к интернету';
        case ApiClientExceptionType.auth:
          return LocaleSwitcher.of(_context!)!.noauth;
          //return 'Неправильный логин!';
        case ApiClientExceptionType.noAnswer:
          return LocaleSwitcher.of(_context!)!.noanswer;
          //return 'Сервер не отвечает!';
        default:
          return LocaleSwitcher.of(_context!)!.defaulterror;
          //return 'Произошла ошибка. Попробуйте еще раз';
      }
    } catch (e) {
      return LocaleSwitcher.of(_context!)!.defaulterror;
    }
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = emailTextInputController.text;
    if (!validateEmail(login)) {
      _updateState(LocaleSwitcher.of(context)!.incorrectformat);
      return;
    }
    _updateState(null);
    _context = context;

    _errorMessage = await _resetPassword(login);
    if (_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    } else {
      _updateState(_errorMessage);
    }
  }

  void _updateState(String? errorMessage) {
    if (_errorMessage == errorMessage) {
      return;
    }
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
