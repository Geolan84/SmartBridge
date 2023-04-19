import 'package:smartbridge/domain/api_client/api_client.dart';
import 'package:smartbridge/domain/models/resume.dart';
import 'package:smartbridge/domain/repositories/resume_repository.dart';
//import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:smartbridge/ui/locales/locale_switcher.dart';
//import 'package:smartbridge/ui/utils.dart';
import 'package:flutter/material.dart';

class AddResumeViewModel extends ChangeNotifier {
  final _resumeService = ResumeRepository();

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

  final TextEditingController aboutInputController = TextEditingController();

  final TextEditingController experienceInputController =
      TextEditingController();

  final TextEditingController educationInputController =
      TextEditingController();

  final TextEditingController telegramInputController = TextEditingController();

  final TextEditingController phoneInputController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  BuildContext? _context;

  bool _isAddProgress = false;
  bool get canStartAdd => !_isAddProgress;
  bool get isAddProgress => _isAddProgress;

  Future<String?> _addResumeToServer() async {
    try {
      Resume newResume = Resume(
        0,
        0,
        schedule,
        lowerSalary,
        upperSalary,
        industry,
        experienceYears,
        isDisabled,
        employment,
        companyType,
        qualification,
        aboutInputController.text,
        experienceInputController.text,
        educationInputController.text,
        phoneInputController.text,
        telegramInputController.text,
        true,
        'updatedAt',
        'geoName',
        'specName',
        regionId,
        specId,
        'name',
        'surname',
        'patronymic',
        'email'
      );
      await _resumeService.addNewResume(newResume);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return LocaleSwitcher.of(_context!)!.networkerror;
        case ApiClientExceptionType.auth:
          return LocaleSwitcher.of(_context!)!.noauth;
        case ApiClientExceptionType.noAnswer:
          return LocaleSwitcher.of(_context!)!.noanswer;
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
          return LocaleSwitcher.of(_context!)!.defaulterror;
      }
    }
    // } catch (e) {
    //   return LocaleSwitcher.of(_context!)!.defaulterror;
    // }
    return null;
  }

  Future<void> saveResume(BuildContext context) async {
    final phone = phoneInputController.text;
    final telegram = telegramInputController.text;
    final about = aboutInputController.text;
    final experience = experienceInputController.text;
    final education = educationInputController.text;


    if (regionId == -1) {
      _updateState('Выберите регион', false);
      return;
    }
    if (specId == -1) {
      _updateState('Выберите специализацию', false);
      return;
    }
    if (schedule == "---") {
      _updateState('Укажите график работы', false);
      return;
    }
    if (industry == "---") {
      _updateState('Выберите индустрию', false);
      return;
    }
    if (companyType == "---") {
      _updateState('Выберите тип компании', false);
      return;
    }
    if (qualification == "---") {
      _updateState('Укажите квалификацию', false);
      return;
    }
    if (employment == "---") {
      _updateState('Выберите тип трудоустройства', false);
      return;
    }
    if (about.isEmpty) {
      _updateState('Заполните поле "О себе"', false);
      return;
    }
    if (phone.isNotEmpty && (phone.length != 11 || phone[0] != '7')) {
      _updateState('Некорректный номер телефона', false);
      return;
    }
    if (telegram.isNotEmpty &&
        (telegram.length < 6 || telegram.length > 33 || telegram[0] != '@')) {
      _updateState('Некорректный telegram', false);
      return;
    }
    if (experience.isEmpty) {
      _updateState('Заполните поле "Опыт"', false);
      return;
    }
    if (education.isEmpty) {
      _updateState('Заполните поле "Образование"', false);
      return;
    }
    if (upperSalary < lowerSalary) {
      _updateState('Верхний порог зарплаты не может быть меньше нижнего!', false);
      return;
    }

    _context = context;
    _updateState(null, true);
    _errorMessage = await _addResumeToServer();

    if (_errorMessage == null) {
      Navigator.of(context).pop();
    } else {
      _updateState(_errorMessage, false);
    }

    _updateState(_errorMessage, false);
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAddProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAddProgress = isAuthProgress;
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
