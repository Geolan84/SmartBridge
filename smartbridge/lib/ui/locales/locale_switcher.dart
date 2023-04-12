import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleSwitcher{
  static const en = Locale('en');
  static const ru = Locale('ru');

  static const supportedLocales = [en, ru];

  
  static LocalizationsDelegate<AppLocalizations> get delegate => AppLocalizations.delegate;

  static dynamic of(BuildContext context) => AppLocalizations.of(context);

  static bool isEn(Locale locale) => locale == en;

  const LocaleSwitcher._();
}