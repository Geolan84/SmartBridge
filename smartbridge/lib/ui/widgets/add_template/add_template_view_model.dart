import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/models/resume.dart';
import 'package:smartbridge/domain/repositories/message_repository.dart';
//import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
//import 'package:smartbridge/ui/utils.dart';
import 'package:flutter/material.dart';

class AddTemplateViewModel extends ChangeNotifier {
  final _messageService = MessageRepository();

  final TextEditingController titleInputController = TextEditingController();

  final TextEditingController bodyInputController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<String?> _addResumeToServer() async {
    try {
      await _messageService.addNewTemplate(titleInputController.text, bodyInputController.text);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return "Проблема с сетью!";
        case ApiClientExceptionType.auth:
          return "Ошибка авторизации";
        case ApiClientExceptionType.noAnswer:
          return "Сервер не отвечает";
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
          return "Неизвестная ошибка";
      }
    }
    // } catch (e) {
    //   return LocaleSwitcher.of(_context!)!.defaulterror;
    // }
    return null;
  }
    

  Future<void> saveTemplate(BuildContext context) async{
    if(titleInputController.text.isEmpty || bodyInputController.text.isEmpty){
      _updateState("Поля не могут быть пустыми");
      return;
    }
    if(titleInputController.text.length > 100){
      _updateState("Название слишком длинное!");
      return;
    }
    if(bodyInputController.text.length > 1000){
      _updateState("Сообщение слишком длинное!");
      return;
    }
    _errorMessage = await _addResumeToServer();
    if (_errorMessage == null) {
      Navigator.of(context).pop();
      //MainNavigation.resetNavigation(context);
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
