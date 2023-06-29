import '../../../../../core/constants/strings/paper_strings.dart';
import '../../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/strings/project_strings.dart';
import '../../../../../core/models/paper_money_model.dart';

part 'paper_money_add_state.dart';

class PaperMoneyAddCubit extends Cubit<PaperMoneyAddState> {
  PaperMoneyAddCubit() : super(PaperMoneyAddInitial());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final paper5Controller = TextEditingController();
  final paper10Controller = TextEditingController();
  final paper20Controller = TextEditingController();
  final paper50Controller = TextEditingController();
  final paper100Controller = TextEditingController();
  final paper200Controller = TextEditingController();

  void changeResult5(String value) {
    emit(state.copyWith(result5: value));
    calculateTotalMoney();
  }

  void changeResult10(String value) {
    emit(state.copyWith(result10: value));
    calculateTotalMoney();
  }

  void changeResult20(String value) {
    emit(state.copyWith(result20: value));
    calculateTotalMoney();
  }

  void changeResult50(String value) {
    emit(state.copyWith(result50: value));
    calculateTotalMoney();
  }

  void changeResult100(String value) {
    emit(state.copyWith(result100: value));
    calculateTotalMoney();
  }

  void changeResult200(String value) {
    emit(state.copyWith(result200: value));
    calculateTotalMoney();
  }

  void calculateTotalMoney() {
    int paper5 = int.parse(state.result5);
    int paper10 = int.parse(state.result10);
    int paper20 = int.parse(state.result20);
    int paper50 = int.parse(state.result50);
    int paper100 = int.parse(state.result100);
    int paper200 = int.parse(state.result200);
    int total = paper5 + paper10 + paper20 + paper50 + paper100 + paper200;
    emit(state.copyWith(totalMoney: total.toString()));
  }

  Future<void> submitBox() async {
    final format = DateFormat.yMMMMEEEEd('tr');
    final date = format.format(DateTime.now());
    int paper5 = int.parse(state.result5);
    int paper10 = int.parse(state.result10);
    int paper20 = int.parse(state.result20);
    int paper50 = int.parse(state.result50);
    int paper100 = int.parse(state.result100);
    int paper200 = int.parse(state.result200);
    int total = paper5 + paper10 + paper20 + paper50 + paper100 + paper200;

    final model = PaperMoneyModel(
      papaperMoney5: paper5,
      papaperMoney10: paper10,
      papaperMoney20: paper20,
      papaperMoney50: paper50,
      papaperMoney100: paper100,
      papaperMoney200: paper200,
      totalMoney: total,
      date: date,
    );

    Box<PaperMoneyModel> box = Hive.box<PaperMoneyModel>(
      ProjectStrings.instance.paperMoneyBoxTitle,
    );
    box.add(model).whenComplete(() {
      scaffoldKey.showGreatSnackBar(PaperStrings.instance.submittedMessage);
    });
  }

  // @override
  // void onChange(Change<PaperMoneyAddState> change) {
  //   calculateTotalMoney();
  //   print('object');
  //   super.onChange(change);
  // }
}
