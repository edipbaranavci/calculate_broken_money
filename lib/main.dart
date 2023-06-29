import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

import 'core/constants/strings/project_strings.dart';
import 'core/models/broken_money_model.dart';
import 'core/models/paper_money_model.dart';
import 'features/home_tabs/views/home_tab_view.dart';

Future<void> initialize() async {
  Intl.defaultLocale = 'tr';
  initializeDateFormatting('tr');
  await Hive.initFlutter();
  Hive
    ..registerAdapter(BrokenMoneyModelAdapter())
    ..registerAdapter(PaperMoneyModelAdapter());
  await Hive.openBox<BrokenMoneyModel>(
      ProjectStrings.instance.brokenMoneyBoxTitle);
  await Hive.openBox<PaperMoneyModel>(
      ProjectStrings.instance.paperMoneyBoxTitle);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.deepPurple),
  );
}

Future<void> main() async {
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ProjectStrings.instance.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: context.border.lowBorderRadius * 0.5,
            ),
          ),
        ),
      ),
      home: const HomeTabsView(),
    );
  }
}
