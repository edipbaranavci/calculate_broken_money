import 'package:calculate_broken_money/product/button/save_button.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/components/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/strings/paper_strings.dart';
import '../cubit/paper_money_add_cubit.dart';

class PaperMoneyAddView extends StatelessWidget {
  const PaperMoneyAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaperMoneyAddCubit>(
      create: (context) => PaperMoneyAddCubit(),
      child: const _PaperMoneyAddView(),
    );
  }
}

class _PaperMoneyAddView extends StatelessWidget {
  const _PaperMoneyAddView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<PaperMoneyAddCubit>().scaffoldKey,
      appBar: CustomAppBar(title: PaperStrings.instance.screenTitle),
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildColumn(context),
          buildTotalMoneyTitle(context),
          context.sized.emptySizedHeightBoxLow,
          Padding(
            padding: context.padding.horizontalMedium,
            child: submitButton(context),
          ),
        ],
      ),
    );
  }

  Widget buildTotalMoneyTitle(BuildContext context) {
    return Padding(
      padding: context.padding.horizontalLow,
      child: Row(
        children: [
          moneyDescriptionContainerItem(
            context,
            PaperStrings.instance.totalMoneyTitle,
          ),
          context.sized.emptySizedWidthBoxNormal,
          Expanded(
            flex: 3,
            child: Center(
              child: BlocBuilder<PaperMoneyAddCubit, PaperMoneyAddState>(
                builder: (context, state) {
                  return Text(
                    '${formatAmount(int.parse(state.totalMoney))}₺',
                    style: context.general.textTheme.bodyLarge,
                  );
                },
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget buildColumn(BuildContext context) {
    final cubit = context.read<PaperMoneyAddCubit>();
    return BlocBuilder<PaperMoneyAddCubit, PaperMoneyAddState>(
      builder: (context, state) {
        return Padding(
          padding: context.padding.horizontalLow,
          child: Column(
            children: [
              buildDescriptionTitles(),
              buildRowString(
                context,
                onChangedValue: (value) => cubit.changeResult5(value),
                countController: cubit.paper5Controller,
                resultString: state.result5,
                multiplyCount: PaperMoneyCounts.moneyCount5,
              ),
              buildRowString(
                context,
                resultString: state.result10,
                onChangedValue: (value) => cubit.changeResult10(value),
                countController: cubit.paper10Controller,
                multiplyCount: PaperMoneyCounts.moneyCount10,
              ),
              buildRowString(
                context,
                resultString: state.result20,
                onChangedValue: (value) => cubit.changeResult20(value),
                countController: cubit.paper20Controller,
                multiplyCount: PaperMoneyCounts.moneyCount20,
              ),
              buildRowString(
                context,
                resultString: state.result50,
                onChangedValue: (value) => cubit.changeResult50(value),
                countController: cubit.paper50Controller,
                multiplyCount: PaperMoneyCounts.moneyCount50,
              ),
              buildRowString(
                context,
                resultString: state.result100,
                onChangedValue: (value) => cubit.changeResult100(value),
                countController: cubit.paper100Controller,
                multiplyCount: PaperMoneyCounts.moneyCount100,
              ),
              buildRowString(
                context,
                resultString: state.result200,
                onChangedValue: (value) => cubit.changeResult200(value),
                countController: cubit.paper200Controller,
                multiplyCount: PaperMoneyCounts.moneyCount200,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget submitButton(BuildContext context) {
    final cubit = context.read<PaperMoneyAddCubit>();
    return SaveButton(
      onPressed: () =>
          cubit.submitBox().whenComplete(() => context.route.pop()),
      title: PaperStrings.instance.submitButtonTitle,
    );
  }

  Widget buildRowString(
    BuildContext context, {
    required TextEditingController countController,
    required String resultString,
    required int multiplyCount,
    required void Function(String value) onChangedValue,
  }) {
    return Padding(
      padding: context.padding.verticalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          moneyDescriptionContainerItem(
            context,
            '$multiplyCount₺',
          ),
          context.sized.emptySizedWidthBoxLow,
          Expanded(
            flex: 3,
            child: SizedBox(
              height: context.sized.normalValue * 3,
              child: buildTextFieldItemString(
                PaperStrings.instance.moneyCountTitle,
                onChanged: (value) => onChangedValue(
                    ((int.tryParse(value) ?? 0) * multiplyCount).toString()),
              ),
            ),
          ),
          context.sized.emptySizedWidthBoxLow,
          buildExportMoneyItem(context, resultString),
        ],
      ),
    );
  }

  Widget buildDescriptionTitles() {
    return Builder(builder: (context) {
      return Padding(
        padding: context.padding.verticalLow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            descriptionTitlesItem(
              context,
              PaperStrings.instance.moneyCategoryTitle,
              3,
              isColor: true,
            ),
            context.sized.emptySizedWidthBoxLow,
            descriptionTitlesItem(
              context,
              PaperStrings.instance.moneyCountTitle,
              3,
            ),
            context.sized.emptySizedWidthBoxLow,
            descriptionTitlesItem(
              context,
              PaperStrings.instance.moneyResultTitle,
              3,
              isColor: true,
            ),
          ],
        ),
      );
    });
  }

  Widget moneyDescriptionContainerItem(BuildContext context, String title) {
    return Expanded(
      flex: 3,
      child: Container(
        height: context.sized.normalValue * 3,
        padding: context.padding.low,
        margin: context.padding.low,
        decoration: BoxDecoration(
          borderRadius: context.border.lowBorderRadius,
          border: Border.all(
            color: context.general.colorScheme.primary,
            width: 2,
          ),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }

  Widget buildTextFieldItemString(
    String label, {
    void Function(String)? onChanged,
  }) {
    return TextField(
      keyboardType: TextInputType.number,
      maxLines: 1,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: label,
        label: Text(label),
      ),
    );
  }

  Widget buildExportMoneyItem(BuildContext context, String money) {
    return Expanded(
      flex: 3,
      child: Container(
        width: context.sized.highValue,
        height: context.sized.normalValue * 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Center(child: Text('$money ₺')),
      ),
    );
  }

  Widget descriptionTitlesItem(
    BuildContext context,
    String title,
    int flex, {
    bool isColor = false,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          title,
          style: context.general.textTheme.titleSmall?.copyWith(
            color: isColor ? context.general.colorScheme.primary : null,
          ),
        ),
      ),
    );
  }

  String formatAmount(int price) =>
      NumberFormat("#,##0", "tr_TR").format(price);
}
