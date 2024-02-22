import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/components/app_bar/custom_app_bar.dart';
import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/money_grams.dart';
import '../../../../../core/constants/strings/broken_strings.dart';
import '../cubit/broken_money_add_cubit.dart';

class BrokenMoneyAddView extends StatelessWidget {
  const BrokenMoneyAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrokenMoneyAddCubit>(
      create: (context) => BrokenMoneyAddCubit(),
      child: const _BrokenMoneyAddView(),
    );
  }
}

class _BrokenMoneyAddView extends StatelessWidget {
  const _BrokenMoneyAddView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<BrokenMoneyAddCubit>().scaffoldKey,
      appBar: CustomAppBar(title: BrokenStrings.instance.screenTitle),
      body: SingleChildScrollView(
        padding: context.padding.horizontalLow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: context.padding.horizontalLow,
              child: buildCoumn(context),
            ),
            context.sized.emptySizedHeightBoxLow,
            buildTotalMoneyTitle(context),
            context.sized.emptySizedHeightBoxLow3x,
            Padding(
              padding: context.padding.horizontalNormal,
              child: submitButton(context),
            ),
          ],
        ),
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
            BrokenStrings.instance.totalMoneyTitle,
          ),
          context.sized.emptySizedWidthBoxNormal,
          Expanded(
            flex: 3,
            child: Center(
              child: BlocBuilder<BrokenMoneyAddCubit, BrokenMoneyAddState>(
                builder: (context, state) {
                  return Text(
                    '${formatAmount(double.parse(state.totalMoney))}₺',
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

  Widget buildCoumn(BuildContext context) {
    final cubit = context.read<BrokenMoneyAddCubit>();
    return BlocBuilder<BrokenMoneyAddCubit, BrokenMoneyAddState>(
      builder: (context, state) {
        return Padding(
          padding: context.padding.verticalLow,
          child: Column(
            children: [
              buildDescriptionTitles(),
              context.sized.emptySizedHeightBoxLow,
              buildRow(
                context,
                countController: cubit.count1Controller,
                divideGram: MoneyGrams.money1Grams,
                gramController: cubit.gram1Controller,
                multiplyCount: BrokenMoneyCounts.moneyCount1,
                resultValue: state.resultMoney1,
                onChangedValue: (value) => cubit.changeResultMoney1(value),
              ),
              context.sized.emptySizedHeightBoxLow,
              buildRow(
                context,
                countController: cubit.count050Controller,
                divideGram: MoneyGrams.money050Grams,
                gramController: cubit.gram050Controller,
                multiplyCount: BrokenMoneyCounts.moneyCount050,
                resultValue: state.resultMoney050,
                onChangedValue: (value) => cubit.changeResultMoney050(value),
              ),
              context.sized.emptySizedHeightBoxLow,
              buildRow(
                context,
                countController: cubit.count025Controller,
                divideGram: MoneyGrams.money025Grams,
                gramController: cubit.gram025Controller,
                multiplyCount: BrokenMoneyCounts.moneyCount025,
                resultValue: state.resultMoney025,
                onChangedValue: (value) => cubit.changeResultMoney025(value),
              ),
              context.sized.emptySizedHeightBoxLow,
              buildRow(
                context,
                countController: cubit.count010Controller,
                divideGram: MoneyGrams.money010Grams,
                gramController: cubit.gram010Controller,
                multiplyCount: BrokenMoneyCounts.moneyCount010,
                resultValue: state.resultMoney010,
                onChangedValue: (value) => cubit.changeResultMoney010(value),
              ),
              context.sized.emptySizedHeightBoxLow,
              buildRow(
                context,
                countController: cubit.count005Controller,
                divideGram: MoneyGrams.money005Grams,
                gramController: cubit.gram005Controller,
                multiplyCount: BrokenMoneyCounts.moneyCount005,
                resultValue: state.resultMoney005,
                onChangedValue: (value) => cubit.changeResultMoney005(value),
              ),
            ],
          ),
        );
      },
    );
  }

  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context
          .read<BrokenMoneyAddCubit>()
          .submitBox()
          .whenComplete(() => context.route.pop()),
      label: Padding(
        padding: context.padding.normal,
        child: Text(BrokenStrings.instance.submitButtonTitle),
      ),
      icon: const Icon(Icons.save),
    );
  }

  Widget buildRow(
    BuildContext context, {
    required TextEditingController gramController,
    required TextEditingController countController,
    required String resultValue,
    required double divideGram,
    required double multiplyCount,
    required void Function(String value) onChangedValue,
  }) {
    final cubit = context.read<BrokenMoneyAddCubit>();
    return Padding(
      padding: context.padding.verticalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          moneyDescriptionContainerItem(
            context,
            '${multiplyCount.toDouble()} ₺',
          ),
          context.sized.emptySizedWidthBoxLow,
          Expanded(
            flex: 3,
            child: SizedBox(
              height: context.sized.normalValue * 3,
              child: buildTextFieldItem(
                BrokenStrings.instance.moneyGramTitle,
                controller: gramController,
                onChanged: (value) {
                  cubit.gramToCount(
                    stringGram: value,
                    bolunecekGram: divideGram,
                    countController: countController,
                    carpilacakMoney: multiplyCount,
                    // resultController: resultController,
                  );
                  onChangedValue(((double.tryParse(countController.text) ?? 0) *
                          multiplyCount)
                      .toStringAsFixed(2));
                },
              ),
            ),
          ),
          context.sized.emptySizedWidthBoxLow,
          Expanded(
            flex: 3,
            child: SizedBox(
              // width: context.sized.width / 4,
              height: context.sized.normalValue * 3,
              child: buildTextFieldItem(
                BrokenStrings.instance.moneyCountTitle,
                controller: countController,
                onChanged: (String value) {
                  cubit.countToGram(
                    // resultController: resultController,
                    carpilacakGram: divideGram,
                    carpilacakMoney: multiplyCount,
                    gramController: gramController,
                    stringCount: value,
                  );
                  onChangedValue(((double.tryParse(value) ?? 0) * multiplyCount)
                      .toStringAsFixed(2));
                },
              ),
            ),
          ),
          context.sized.emptySizedWidthBoxLow,
          buildExportMoneyItem(context, resultValue),
        ],
      ),
    );
  }

  Widget buildDescriptionTitles() {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          descriptionTitlesItem(
            context,
            BrokenStrings.instance.moneyCategoryTitle,
            isColor: true,
          ),
          context.sized.emptySizedWidthBoxLow,
          descriptionTitlesItem(
            context,
            BrokenStrings.instance.moneyGramTitle,
          ),
          context.sized.emptySizedWidthBoxLow,
          descriptionTitlesItem(
            context,
            BrokenStrings.instance.moneyCountTitle,
          ),
          context.sized.emptySizedWidthBoxLow,
          descriptionTitlesItem(
            context,
            BrokenStrings.instance.moneyResultTitle,
            isColor: true,
          ),
        ],
      );
    });
  }

  Widget moneyDescriptionContainerItem(BuildContext context, String title) {
    return Expanded(
      flex: 3,
      child: Container(
        height: context.sized.normalValue * 3,
        padding: context.padding.low,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.general.colorScheme.primary,
            width: 2,
          ),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }

  TextField buildTextFieldItem(
    String label, {
    Function(String)? onChanged,
    required TextEditingController controller,
  }) {
    return TextField(
      keyboardType: TextInputType.number,
      maxLines: 1,
      controller: controller,
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

  Widget descriptionTitlesItem(BuildContext context, String title,
      {bool isColor = false}) {
    return Expanded(
      flex: 3,
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

  String formatAmount(double price) =>
      NumberFormat("#,##0.00", "tr_TR").format(price);
}
