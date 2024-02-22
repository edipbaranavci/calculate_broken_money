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

  Future<void> _init() async {
    await getColorSettings();
  }

  Future<void> getColorSettings() async {
    final box = await Hive.openBox(_constants.colorConstantsKey);
    try {
      final isDarkMode = box.get(_constants.colorConstantsDarkModeKey);
      final colorIndex = box.get(_constants.colorConstantsKey);
      if ((isDarkMode == null) && (colorIndex == null)) {
        emit(state.copyWith(
          color: _constants.allColor[colorIndex ?? 0],
          colorIndex: colorIndex,
          isDarkMode: true,
        ));
      } else {
        emit(state.copyWith(
          color: _constants.allColor[colorIndex ?? 0],
          colorIndex: colorIndex,
          isDarkMode: isDarkMode,
        ));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
