import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartbridge/domain/data_providers/session_data_provider.dart';
import 'package:smartbridge/domain/repositories/profile_repository.dart';
import 'package:smartbridge/domain/repositories/auth_repository.dart';
import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'dart:async';
import 'dart:io';
//import 'package:smartbridge/ui/locales/locale_switcher.dart';



class SettingsViewModel extends ChangeNotifier{
  final _profileRepository = ProfileRepository();
  final _authService = AuthRepository();
  //File? _image;
  Image avatar = Image.asset("assets/images/avatar.jpg");
                    
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  SettingsViewModel(){
    downloadPhoto();
    notifyListeners();
  }
  
  Future<void> downloadPhoto() async{
    var userId = await SessionDataProvider().getUserId();
    avatar = Image.network('http://10.0.2.2:8080/profile/photo/$userId');
    //avatar = Image.network('https://smartbridge.onrender.com/profile/photo/$userId');
    notifyListeners();
  }

  Future<String?> _deleteProfile() async{
    try{
      await _profileRepository.deleteProfile();
    } on ApiClientException catch(e){
      switch(e.type){
       case ApiClientExceptionType.network:
          //return LocaleSwitcher.of(context)!.networkerror;
          return 'Сервер не доступен. Проверте подключение к интернету';
        case ApiClientExceptionType.auth:
          return 'Ошибка удаления';
        case ApiClientExceptionType.noAnswer:
          //return LocaleSwitcher.of(context)!.noanswer;
          return 'Сервер не отвечает!';
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
          //return LocaleSwitcher.of(context)!.defaulterror;
          return 'Произошла ошибка. Попробуйте еще раз';
      }
    } catch (e) {
      //return LocaleSwitcher.of(_context!)!.defaulterror;
      return 'Неизвестная ошибка, поторите попытку';
    }
    return null;
  }

  Future<bool> uploadPhoto(XFile? image) async{
    if(image == null){
      return false;
    }
    File file = File(image.path);
    try{
       await _profileRepository.uploadImage(file);
       avatar = Image.file(File(file.path));
       notifyListeners();
    } catch(_){
      return false;
    }
    return true;
  }

  Future<void> deleteProfile(BuildContext context) async {
    _errorMessage = await _deleteProfile();
    if (_errorMessage == null) {
      _authService.logout();
      Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.loaderWidget);
    } else {
      _updateState(_errorMessage);
    }
  }

  void _updateState(String? errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }
}

