import 'package:calculate_broken_money/core/extensions/scaffold_messenger/snack_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/strings/broken_strings.dart';
import '../../../../../core/constants/strings/project_strings.dart';
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

  final resultMoney1 = TextEditingController(text: '0');
  final resultMoney050 = TextEditingController(text: '0');
  final resultMoney025 = TextEditingController(text: '0');
  final resultMoney010 = TextEditingController(text: '0');
  final resultMoney005 = TextEditingController(text: '0');

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void gramToCount({
    required TextEditingController resultController,
    required String stringGram,
    required double bolunecekGram,
    required TextEditingController countController,
    required double carpilacakMoney,
  }) {
    double returnValue = 0;
    final gram = double.tryParse(stringGram) ?? 0;
    if (gram > 0) {
      int count = gram ~/ bolunecekGram;
      returnValue = count * carpilacakMoney;
      countController.text = count.toString();
    }
    resultController.text = returnValue.toStringAsFixed(2);
  }

  void countToGram({
    required TextEditingController resultController,
    required String stringCount,
    required double carpilacakGram,
    required TextEditingController gramController,
    required double carpilacakMoney,
  }) {
    double returnValue = 0;
    final count = int.tryParse(stringCount) ?? 0;
    if (count > 0) {
      double gram = count * carpilacakGram;
      returnValue = count * carpilacakMoney;
      gramController.text = gram.toString();
    }
    resultController.text = returnValue.toStringAsFixed(2);
    emit(state);
  }

  Future<void> submitBox() async {
    final format = DateFormat.yMMMMEEEEd('tr');
    final date = format.format(DateTime.now());
    double money1 = double.parse(resultMoney1.text);
    double money050 = double.parse(resultMoney050.text);
    double money025 = double.parse(resultMoney025.text);
    double money010 = double.parse(resultMoney010.text);
    double money005 = double.parse(resultMoney005.text);
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
