import 'package:calculate_broken_money/core/constants/colors/color_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'custom_drawer_state.dart';

class CustomDrawerCubit extends Cubit<CustomDrawerState> {
  CustomDrawerCubit() : super(CustomDrawerInitial()) {
    _init();
  }

  final _constants = ColorConstants.instance;

  Future<void> _init() async {
    try {
      final box = await Hive.openBox(_constants.colorConstantsKey);
      final isDarkMode = box.get(_constants.colorConstantsDarkModeKey);
      final colorIndex = box.get(_constants.colorConstantsKey);
      emit(state.copyWith(colorIndex: colorIndex, isDarkMode: isDarkMode));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<void> setColor(int index) async {
    final box = await Hive.openBox(_constants.colorConstantsKey);
    await box.put(_constants.colorConstantsKey, index);
    // await setDarkMode(false);
    await _init();
  }

  Future<void> setDarkMode(bool isDarkMode) async {
    final box = await Hive.openBox(_constants.colorConstantsKey);
    await box.put(_constants.colorConstantsDarkModeKey, isDarkMode);
    await _init();
  }
}
