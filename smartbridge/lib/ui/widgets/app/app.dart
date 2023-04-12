import 'package:flutter/material.dart';
import 'package:smartbridge/ui/navigation/main_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BridgeApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const BridgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartBridge',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.loaderWidget,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}