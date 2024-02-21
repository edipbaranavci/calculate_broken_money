import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/constants/colors/color_constants.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial()) {
    _init();
  }
  final _constants = ColorConstants.instance;

  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> _init() async {
    await getColorSettings();
    // await checkForUpdate();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> checkForUpdate() async {Upgra}

  Future<void> getColorSettings() async {
    final box = await Hive.openBox(_constants.colorConstantsKey);
    try {
      final isDarkMode = box.get(_constants.colorConstantsDarkModeKey);
      final colorIndex = box.get(_constants.colorConstantsKey);
      emit(state.copyWith(
        color: _constants.allColor[colorIndex],
        colorIndex: colorIndex,
        isDarkMode: isDarkMode,
      ));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
