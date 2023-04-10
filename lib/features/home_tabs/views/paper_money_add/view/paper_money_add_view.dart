import 'package:calculate_broken_money/core/components/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/strings/paper_strings.dart';
import '../../../../../product/ads/view/ads_view.dart';
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

  SingleChildScrollView buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildColumn(context),
          const AdsBanner(),
          submitButton(context),
        ],
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    final cubit = context.read<PaperMoneyAddCubit>();
    return Column(
      children: [
        buildDescriptionTitles(),
        buildRow(
          context,
          countController: cubit.paper5Controller,
          multiplyCount: PaperMoneyCounts.moneyCount5,
          resultController: cubit.result5Controller,
        ),
        buildRow(
          context,
          countController: cubit.paper10Controller,
          multiplyCount: PaperMoneyCounts.moneyCount10,
          resultController: cubit.result10Controller,
        ),
        buildRow(
          context,
          countController: cubit.paper20Controller,
          multiplyCount: PaperMoneyCounts.moneyCount20,
          resultController: cubit.result20Controller,
        ),
        buildRow(
          context,
          countController: cubit.paper50Controller,
          multiplyCount: PaperMoneyCounts.moneyCount50,
          resultController: cubit.result50Controller,
        ),
        buildRow(
          context,
          countController: cubit.paper100Controller,
          multiplyCount: PaperMoneyCounts.moneyCount100,
          resultController: cubit.result100Controller,
        ),
        buildRow(
          context,
          countController: cubit.paper200Controller,
          multiplyCount: PaperMoneyCounts.moneyCount200,
          resultController: cubit.result200Controller,
        ),
      ],
    );
  }

  ElevatedButton submitButton(BuildContext context) {
    final cubit = context.read<PaperMoneyAddCubit>();
    return ElevatedButton.icon(
      onPressed: () => cubit.submitBox().whenComplete(() => context.pop()),
      label: Text(PaperStrings.instance.submitButtonTitle),
      icon: const Icon(Icons.save),
    );
  }

  Widget buildRow(
    BuildContext context, {
    required TextEditingController countController,
    required TextEditingController resultController,
    required int multiplyCount,
  }) {
    final cubit = context.read<PaperMoneyAddCubit>();
    return Padding(
      padding: context.verticalPaddingLow,
      child: Builder(builder: (contextState) {
        return Row(
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
                child: buildTextFieldItem(
                  PaperStrings.instance.moneyCountTitle,
                  controller: countController,
                  onSubmitted: (String value) => cubit.paperCalculate(
                    multiplyCount: multiplyCount,
                    resultController: resultController,
                    stringValue: value,
                  ),
                ),
              ),
            ),
            buildExportMoneyItem(context, resultController.text),
          ],
        );
      }),
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
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.colorScheme.primary,
            width: 2,
          ),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }

  Widget buildTextFieldItem(
    String label, {
    Function(String)? onSubmitted,
    required TextEditingController controller,
  }) {
    return Builder(builder: (context) {
      return TextField(
        keyboardType: TextInputType.number,
        maxLines: 1,
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: label,
          label: Text(label),
        ),
      );
    });
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
