import 'package:smartbridge/ui/widgets/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'dart:async';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final log = Logger('Main Class');
  runZonedGuarded(
    () {
      log.info("Start main");
      runApp(const BridgeApp());
    },
    (e, stackTrace) => log.severe('Error!', e, stackTrace),
  );
}
