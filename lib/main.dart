import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upgrader/upgrader.dart';

import 'core/constants/strings/project_strings.dart';
import 'core/models/broken_money_model.dart';
import 'core/models/paper_money_model.dart';
import 'cubit/main_cubit.dart';
import 'features/home_tabs/views/home_tab_view.dart';

Future<void> initialize() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(BrokenMoneyModelAdapter())
    ..registerAdapter(PaperMoneyModelAdapter());
  await Hive.openBox<BrokenMoneyModel>(
      ProjectStrings.instance.brokenMoneyBoxTitle);
  await Hive.openBox<PaperMoneyModel>(
      ProjectStrings.instance.paperMoneyBoxTitle);
}

Future<void> main() async {
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(),
      child: const _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    Upgrader.clearSavedSettings();
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final color =
            state.color != null ? state.color as MaterialColor : Colors.purple;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: state.color),
        );
        return MaterialApp(
          title: ProjectStrings.instance.appTitle,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('tr', 'TR')],
          debugShowCheckedModeBanner: false,
          theme: (state.isDarkMode == true)
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData(
                  useMaterial3: true,
                  primarySwatch: color,
                  primaryColor: color,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: state.color ?? Colors.purple,
                  ),
                  brightness: state.isDarkMode == true
                      ? Brightness.dark
                      : Brightness.light,
                ),
          home: BlocProvider.value(
            value: context.read<MainCubit>(),
            child: UpgradeAlert(
              showIgnore: false,
              dialogStyle: UpgradeDialogStyle.cupertino,
              showLater: true,
              showReleaseNotes: true,
              canDismissDialog: true,
              child: const HomeTabsView(),
            ),
          ),
        );
      },
    );
  }
}
