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

  final result5Controller = TextEditingController(text: '0');
  final result10Controller = TextEditingController(text: '0');
  final result20Controller = TextEditingController(text: '0');
  final result50Controller = TextEditingController(text: '0');
  final result100Controller = TextEditingController(text: '0');
  final result200Controller = TextEditingController(text: '0');

  void paperCalculate({
    required String stringValue,
    required int multiplyCount,
    required TextEditingController resultController,
  }) {
    final count = int.tryParse(stringValue) ?? 0;
    if (count > 0) {
      resultController.text = (count * multiplyCount).toString();
    }
  }

  Future<void> submitBox() async {
    final format = DateFormat.yMMMMEEEEd('tr');
    final date = format.format(DateTime.now());
    int paper5 = int.parse(result5Controller.text);
    int paper10 = int.parse(result10Controller.text);
    int paper20 = int.parse(result20Controller.text);
    int paper50 = int.parse(result50Controller.text);
    int paper100 = int.parse(result100Controller.text);
    int paper200 = int.parse(result200Controller.text);
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
}
