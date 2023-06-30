import '../../../../../core/components/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/strings/paper_strings.dart';
import '../cubit/paper_money_add_cubit.dart';

class PaperMoneyAddView extends StatelessWidget {
  const PaperMoneyAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaperMoneyAddCubit>(
      create: (context) => PaperMoneyAddCubit(),
      child: const _PaperMoneyAddView(),
    );
  }
}

class _PaperMoneyAddView extends StatelessWidget {
  const _PaperMoneyAddView({Key? key}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildColumn(context),
          buildTotalMoneyTitle(context),
          context.sized.emptySizedHeightBoxLow,
          submitButton(context),
        ],
      ),
    );
  }

  Row buildTotalMoneyTitle(BuildContext context) {
    return Row(
      children: [
        moneyDescriptionContainerItem(
          context,
          PaperStrings.instance.totalMoneyTitle,
        ),
        context.emptySizedWidthBoxNormal,
        Expanded(
          flex: 3,
          child: Center(
            child: BlocBuilder<PaperMoneyAddCubit, PaperMoneyAddState>(
              builder: (context, state) {
                return Text(
                  '${state.totalMoney}₺',
                  style: context.textTheme.bodyLarge,
                );
              },
            ),
          ),
        ),
        const Expanded(flex: 2, child: SizedBox.shrink()),
      ],
    );
  }

  Widget buildColumn(BuildContext context) {
    final cubit = context.read<PaperMoneyAddCubit>();
    return BlocBuilder<PaperMoneyAddCubit, PaperMoneyAddState>(
      builder: (context, state) {
        return Column(
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
        );
      },
    );
  }

  ElevatedButton submitButton(BuildContext context) {
    final cubit = context.read<PaperMoneyAddCubit>();
    return ElevatedButton.icon(
      onPressed: () => cubit.submitBox().whenComplete(() => context.pop()),
      label: Padding(
        padding: context.padding.normal,
        child: Text(PaperStrings.instance.submitButtonTitle),
      ),
      icon: const Icon(Icons.save),
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
      padding: context.verticalPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          moneyDescriptionContainerItem(
            context,
            '$multiplyCount₺',
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: context.normalValue * 3,
              child: buildTextFieldItemString(
                PaperStrings.instance.moneyCountTitle,
                onChanged: (value) => onChangedValue(
                    ((int.tryParse(value) ?? 0) * multiplyCount).toString()),
              ),
            ),
          ),
          buildExportMoneyItem(context, resultString),
        ],
      ),
    );
  }

  Widget buildDescriptionTitles() {
    return Builder(builder: (context) {
      return Padding(
        padding: context.verticalPaddingLow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            descriptionTitlesItem(
              context,
              PaperStrings.instance.moneyCategoryTitle,
              3,
              isColor: true,
            ),
            descriptionTitlesItem(
              context,
              PaperStrings.instance.moneyCountTitle,
              4,
            ),
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
        height: context.normalValue * 3,
        padding: context.paddingLow,
        margin: context.paddingLow,
        decoration: BoxDecoration(
          borderRadius: context.lowBorderRadius,
          border: Border.all(
            color: context.colorScheme.primary,
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
        width: context.highValue,
        height: context.normalValue * 3,
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
      child: SizedBox(
        height: context.normalValue * 3,
        child: Center(
          child: Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              color: isColor ? context.colorScheme.primary : null,
            ),
          ),
        ),
      ),
    );
  }
}
