import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/repositories/auth_repository.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:smartbridge/ui/utils.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authService = AuthRepository();

  final TextEditingController emailTextInputController =
      TextEditingController();

  final TextEditingController passwordTextInputController =
      TextEditingController();

  final TextEditingController firstNameTextInputController =
      TextEditingController();

  final TextEditingController secondNameTextInputController =
      TextEditingController();

  final TextEditingController patronymicTextInputController =
      TextEditingController();


  Future<void> loadDetails(BuildContext context) async {
    // try {
    //   final ditails = await _authService.loadDetails();
    //   updateData(ditails.details, ditails.isFavorite);
    // } on ApiClientException catch (e) {
    //   _handleApiClientException(e, context);
    // }
  }

  String? _errorMessage;
  DateTime? birthday;
  String? get errorMessage => _errorMessage;

  bool _isRegistrationProgress = false;
  bool get canStartAuth => !_isRegistrationProgress;
  bool get isRegistrationProgress => _isRegistrationProgress;

  Future<String?> _register(
    BuildContext context,
    String email,
    String password,
    String firstName,
    String secondName,
    String? patronymic,
    DateTime? birthday,
    bool isHR,
  ) async {
    if (birthday == null) {
      return "Введите дату рождения";
    }
    try {
      await _authService.register(
          email, password, firstName, secondName, patronymic, birthday, isHR);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return LocaleSwitcher.of(context)!.networkerror;
        //return 'Сервер не доступен. Проверте подключение к интернету';
        case ApiClientExceptionType.auth:
          return LocaleSwitcher.of(context)!.noauth;
        //return 'Неправильный логин пароль!';
        case ApiClientExceptionType.noAnswer:
          return LocaleSwitcher.of(context)!.noanswer;
        //return 'Сервер не отвечает!';
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
          return LocaleSwitcher.of(context)!.defaulterror;
        //return 'Произошла ошибка. Попробуйте еще раз';
      }
    } catch (e) {
      return LocaleSwitcher.of(context)!.defaulterror;
      //return 'Неизвестная ошибка, поторите попытку';
    }
    return null;
  }

  Future<void> register(BuildContext context, DateTime? date, bool isHR) async {
    final email = emailTextInputController.text;
    final password = passwordTextInputController.text;
    final firstName = firstNameTextInputController.text;
    final secondName = secondNameTextInputController.text;
    final patronymic = patronymicTextInputController.text;

    if (!validateEmail(email) ||
        !validatePassword(password) ||
        firstName.length > 50 ||
        firstName.isEmpty ||
        secondName.length > 50 ||
        secondName.isEmpty) {
      _updateState(LocaleSwitcher.of(context)!.noauth, false);
      return;
    }

    _updateState(null, true);
    //Try to auth.
    _errorMessage = await _register(context, email, password, firstName,
        secondName, patronymic, date, isHR);

    if (_errorMessage == null) {
      try {
        _authService.login(email, password);
        MainNavigation.resetNavigation(context);
      } catch (e) {
        //print(e);
        Navigator.of(context).pushReplacementNamed('/auth');
      }
      //MainNavigation.resetNavigation(context);
    } else {
      //print(_errorMessage);
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isRegistrationProgress) {
    if (_errorMessage == errorMessage &&
        _isRegistrationProgress == isRegistrationProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isRegistrationProgress = isRegistrationProgress;
    notifyListeners();
  }
}
