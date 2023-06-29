import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/strings/broken_strings.dart';
import '../../../../../core/constants/strings/project_strings.dart';
import '../../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import '../../../../../core/models/broken_money_model.dart';

part 'broken_money_add_state.dart';

class BrokenMoneyAddCubit extends Cubit<BrokenMoneyAddState> {
  BrokenMoneyAddCubit() : super(BrokenMoneyAddInitial());

  final count1Controller = TextEditingController();
  final count050Controller = TextEditingController();
  final count025Controller = TextEditingController();
  final count010Controller = TextEditingController();
  final count005Controller = TextEditingController();

  final gram1Controller = TextEditingController();
  final gram050Controller = TextEditingController();
  final gram025Controller = TextEditingController();
  final gram010Controller = TextEditingController();
  final gram005Controller = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void changeResultMoney005(String value) {
    emit(state.copyWith(resultMoney005: value));
    calculateTotalMoney();
  }

  void changeResultMoney010(String value) {
    emit(state.copyWith(resultMoney010: value));
    calculateTotalMoney();
  }

  void changeResultMoney025(String value) {
    emit(state.copyWith(resultMoney025: value));
    calculateTotalMoney();
  }

  void changeResultMoney050(String value) {
    emit(state.copyWith(resultMoney050: value));
    calculateTotalMoney();
  }

  void changeResultMoney1(String value) {
    emit(state.copyWith(resultMoney1: value));
    calculateTotalMoney();
  }

  void calculateTotalMoney() {
    double paper5 = double.parse(state.resultMoney005);
    double paper10 = double.parse(state.resultMoney010);
    double paper20 = double.parse(state.resultMoney025);
    double paper50 = double.parse(state.resultMoney050);
    double paper100 = double.parse(state.resultMoney1);
    double total = paper5 + paper10 + paper20 + paper50 + paper100;
    emit(state.copyWith(totalMoney: total.toStringAsFixed(2)));
  }

  void gramToCount({
    // required String resultString,
    required String stringGram,
    required double bolunecekGram,
    required TextEditingController countController,
    required double carpilacakMoney,
  }) {
    // double returnValue = 0;
    final gram = double.tryParse(stringGram) ?? 0;
    if (gram > 0) {
      int count = gram ~/ bolunecekGram;
      // returnValue = count * carpilacakMoney;
      countController.text = count.toString();
    } else {
      countController.text = '';
    }
    // resultString = returnValue.toStringAsFixed(2);
  }

  void countToGram({
    // required TextEditingController resultController,
    required String stringCount,
    required double carpilacakGram,
    required TextEditingController gramController,
    required double carpilacakMoney,
  }) {
    // double returnValue = 0;
    final count = int.tryParse(stringCount) ?? 0;
    if (count > 0) {
      double gram = count * carpilacakGram;
      // returnValue = count * carpilacakMoney;
      gramController.text = gram.toString();
    } else {
      gramController.text = '';
    }
    // resultController.text = returnValue.toStringAsFixed(2);
    // emit(state);
  }

  Future<void> submitBox() async {
    final format = DateFormat.yMMMMEEEEd('tr');
    final date = format.format(DateTime.now());
    double money1 = double.parse(state.resultMoney1);
    double money050 = double.parse(state.resultMoney050);
    double money025 = double.parse(state.resultMoney025);
    double money010 = double.parse(state.resultMoney010);
    double money005 = double.parse(state.resultMoney005);
    double totalMoney = money1 + money050 + money025 + money010 + money005;

    final model = BrokenMoneyModel(
      brokenMoney_1: money1,
      brokenMoney_050: money050,
      brokenMoney_025: money025,
      brokenMoney_010: money010,
      brokenMoney_005: money005,
      date: date,
      totalMoney: totalMoney,
    );
    Box<BrokenMoneyModel> box = Hive.box<BrokenMoneyModel>(
      ProjectStrings.instance.brokenMoneyBoxTitle,
    );
    box.add(model).whenComplete(() {
      scaffoldKey.showGreatSnackBar(BrokenStrings.instance.submittedMessage);
    });
  }
}
