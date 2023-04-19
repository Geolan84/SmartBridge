import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/models/resume.dart';
import 'package:smartbridge/domain/repositories/resume_repository.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
//import 'package:smartbridge/ui/utils.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final _resumeService = ResumeRepository();
  List<Resume> search_res = List<Resume>.empty();

  int lowerSalary = 50000;
  int upperSalary = 50000;
  int regionId = -1;
  int experienceYears = 0;
  bool isDisabled = false;
  int specId = -1;
  String industry = '---';
  String companyType = '---';
  String qualification = '---';
  String schedule = '---';
  String employment = '---';
  List<int> skills = [];

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<String?> _search() async {
    try {
      search_res = await _resumeService.searchResumes();
      search_res = search_res.where((element) => element.lowerSalary > lowerSalary && element.upperSalary < upperSalary).toList();
      search_res = search_res.where((element) => element.isDisabled == isDisabled).toList();
      if(industry != "---"){
        search_res = search_res.where((element) => element.industry == industry).toList();
      }
      if(companyType != "---"){
        search_res = search_res.where((element) => element.companyType == companyType).toList();
      }
      if(regionId != -1){
        search_res = search_res.where((element) => element.region == regionId).toList();
      }
      if(schedule != '---'){
        search_res = search_res.where((element) => element.schedule == schedule).toList();
      }
      if(qualification != '---'){
        search_res = search_res.where((element) => element.qualification == qualification).toList();
      }
      if(employment != '---'){
        search_res = search_res.where((element) => element.employment == employment).toList();
      }
      
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return "Ошибка сети!";
        case ApiClientExceptionType.auth:
          return "Ошибка входа!";
        case ApiClientExceptionType.noAnswer:
          return "Ошибка сервера!";
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
          return "Неизвестная ошибка!";
      }
    }
    return null;
  }

  Future<void> searchResumes(BuildContext context) async {
    _updateState(null);
    _errorMessage = await _search();
    if (_errorMessage == null) {
      Navigator.of(context).pushNamed(
                MainNavigationRouteNames.hrResumeList, arguments: search_res
              );
    } else {
      _updateState(_errorMessage);
    }

    _updateState(_errorMessage);
  }

  void _updateState(String? errorMessage) {
    if (_errorMessage == errorMessage) {
      return;
    }
    _errorMessage = errorMessage;
    notifyListeners();
  }

  Future<void> updateCompanyType(String value) async {
    companyType = value;
  }

  Future<void> updateSchedule(String value) async {
    schedule = value;
  }

  Future<void> updateIndustry(String value) async {
    industry = value;
  }

  Future<void> updateDisabled(bool value) async {
    isDisabled = value;
    notifyListeners();
  }

  Future<void> updateEmployment(String value) async {
    employment = value;
  }

  Future<void> updateSkills(List<String> newSkills) async {
    skills = [for (var i in newSkills) skillsName.indexOf(i)];
  }

  Future<void> updateSpecId(String spec) async {
    specId = specializations.indexOf(spec) + 1;
  }

  Future<void> updateQulification(String value) async {
    qualification = value;
  }

  Future<void> updateRegionID(String value) async {
    regionId = regions.indexOf(value.toString()) + 1;
    notifyListeners();
  }

Future<void> onIncrementLowerButtonPressed() async {
    if(lowerSalary < upperSalary){
        lowerSalary += 5000;
        notifyListeners();
    }
  }

  Future<void> onDecrementLowerButtonPressed() async {
    if(lowerSalary > 5000){
      lowerSalary -= 5000;
      notifyListeners();
    }
  }

  Future<void> onIncrementUpperButtonPressed() async {
    upperSalary += 5000;
    notifyListeners();
  }

  Future<void> onDecrementUpperButtonPressed() async {
    if(upperSalary > 5000 && upperSalary > lowerSalary){
      upperSalary -= 5000;
      notifyListeners();
    }
  }

  List<String> qualifications = const [
    'intern',
    'junior',
    'middle',
    'senior',
    'lead',
  ];

  List<String> specializations = const [
    'QA-инженер»',
    'Разработчик',
    'Архитектор',
    'Технический писатель',
    'Системный аналитик',
    'Бизнес-аналитик',
  ];

  List<String> skillsName = const [
    'Python',
    'C/C++',
    'SAS',
    'SQL',
    'BPMN',
    'UML',
    'Archimate',
    'Visual Paradigm',
    'Golang',
    'Java',
    'C#',
    'Lua',
    'Javascript',
    'Kotlin',
    'Dart',
    'Ruby',
    'VBA',
    'PHP',
    'WordPress',
    'Flutter',
    'Microsoft Office',
    'QT',
    'PyQT',
    'Git',
    'Docker',
    'Kubernetes',
    'Pytest',
    'JUnit',
    'Spring',
    'Netty',
    'ASP.NET',
    'WPF',
    'CI',
    'Jira',
    'Asana',
    'Agile',
    'SCRUM',
    'Slack',
    'CL',
    'EPC',
    'Clion',
    'Pycharm',
    'Visual Studio',
    'Goland',
    'Intelij Idea',
    'VS Code',
    'Android Studio',
    'Swift',
    'JavaFX',
    'Swing',
    'FastAPI',
    'Django'
  ];

  List<String> regions = const [
    'Адыгея (Республика Адыгея)',
    'Алтай (Республика Алтай)',
    'Алтайский край',
    'Амурская область',
    'Архангельская область',
    'Астраханская область',
    'Башкортостан (Республика Башкортостан)',
    'Белгородская область',
    'Брянская область',
    'Бурятия (Республика Бурятия)',
    'Владимирская область',
    'Волгоградская область',
    'Вологодская область',
    'Воронежская область',
    'Дагестан (Республика Дагестан)',
    'Донецкая Народная Республика',
    'Еврейская автономная область',
    'Забайкальский край',
    'Запорожская область',
    'Ивановская область',
    'Ингушетия (Республика Ингушетия)',
    'Иркутская область',
    'Кабардино-Балкария (Кабардино-Балкарская Республика)',
    'Калининградская область',
    'Калмыкия (Республика Калмыкия)',
    'Калужская область',
    'Камчатский край',
    'Карачаево-Черкесия (Карачаево-Черкесская Республика)',
    'Карелия (Республика Карелия)',
    'Кемеровская область',
    'Кировская область',
    'Коми (Республика Коми)',
    'Костромская область',
    'Краснодарский край (Кубань)',
    'Красноярский край',
    'Крым (Республика Крым)',
    'Курганская область',
    'Курская область',
    'Ленинградская область',
    'Липецкая область',
    'Луганская Народная Республика',
    'Магаданская область',
    'Марий Эл (Республика Марий Эл)',
    'Мордовия (Республика Мордовия)',
    'Москва',
    'Московская область',
    'Мурманская область',
    'Ненецкий автономный округ',
    'Нижегородская область',
    'Новгородская область',
    'Новосибирская область',
    'Омская область',
    'Оренбургская область',
    'Орловская область',
    'Пензенская область',
    'Пермский край',
    'Приморский край',
    'Псковская область',
    'Ростовская область',
    'Рязанская область',
    'Самарская область',
    'Санкт-Петербург',
    'Саратовская область',
    'Саха (Республика Саха (Якутия))',
    'Сахалинская область',
    'Свердловская область',
    'Севастополь',
    'Северная Осетия (Республика Северная Осетия — Алания)',
    'Смоленская область',
    'Ставропольский край',
    'Тамбовская область',
    'Татарстан (Республика Татарстан)',
    'Тверская область',
    'Томская область',
    'Тульская область',
    'Тыва (Республика Тыва)',
    'Тюменская область',
    'Удмуртия (Удмуртская Республика)',
    'Ульяновская область',
    'Хабаровский край',
    'Хакасия (Республика Хакасия)',
    'Ханты-Мансийский автономный округ — Югра',
    'Херсонская область',
    'Челябинская область',
    'Чечня (Чеченская Республика)',
    'Чувашия (Чувашская Республика)',
    'Чукотка (Чукотский автономный округ)',
    'Ямало-Ненецкий автономный округ',
    'Ярославская область'
  ];
}
