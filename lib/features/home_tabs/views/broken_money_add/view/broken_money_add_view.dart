import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/components/app_bar/custom_app_bar.dart';
import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/money_grams.dart';
import '../../../../../core/constants/strings/broken_strings.dart';
import '../cubit/broken_money_add_cubit.dart';

class BrokenMoneyAddView extends StatelessWidget {
  const BrokenMoneyAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrokenMoneyAddCubit>(
      create: (context) => BrokenMoneyAddCubit(),
      child: const _BrokenMoneyAddView(),
    );
  }
}

class _BrokenMoneyAddView extends StatelessWidget {
  const _BrokenMoneyAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<BrokenMoneyAddCubit>().scaffoldKey,
      appBar: CustomAppBar(title: BrokenStrings.instance.screenTitle),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCoumn(context),
            submitButton(context),
          ],
        ),
      ),
    );
  }

  Column buildCoumn(BuildContext context) {
    final cubit = context.read<BrokenMoneyAddCubit>();
    return Column(
      children: [
        buildDescriptionTitles(),
        buildRow(
          context,
          countController: cubit.count1Controller,
          divideGram: MoneyGrams.money1Grams,
          gramController: cubit.gram1Controller,
          multiplyCount: BrokenMoneyCounts.moneyCount1,
          resultController: cubit.resultMoney1,
        ),
        buildRow(
          context,
          countController: cubit.count050Controller,
          divideGram: MoneyGrams.money050Grams,
          gramController: cubit.gram050Controller,
          multiplyCount: BrokenMoneyCounts.moneyCount050,
          resultController: cubit.resultMoney050,
        ),
        buildRow(
          context,
          countController: cubit.count025Controller,
          divideGram: MoneyGrams.money025Grams,
          gramController: cubit.gram025Controller,
          multiplyCount: BrokenMoneyCounts.moneyCount025,
          resultController: cubit.resultMoney025,
        ),
        buildRow(
          context,
          countController: cubit.count010Controller,
          divideGram: MoneyGrams.money010Grams,
          gramController: cubit.gram010Controller,
          multiplyCount: BrokenMoneyCounts.moneyCount010,
          resultController: cubit.resultMoney010,
        ),
        buildRow(
          context,
          countController: cubit.count005Controller,
          divideGram: MoneyGrams.money005Grams,
          gramController: cubit.gram005Controller,
          multiplyCount: BrokenMoneyCounts.moneyCount005,
          resultController: cubit.resultMoney005,
        ),
      ],
    );
  }

  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context
          .read<BrokenMoneyAddCubit>()
          .submitBox()
          .whenComplete(() => context.pop()),
      label: Text(BrokenStrings.instance.submitButtonTitle),
      icon: const Icon(Icons.save),
    );
  }

  Widget buildRow(
    BuildContext context, {
    required TextEditingController gramController,
    required TextEditingController countController,
    required TextEditingController resultController,
    required double divideGram,
    required double multiplyCount,
  }) {
    final cubit = context.read<BrokenMoneyAddCubit>();
    return Padding(
      padding: context.verticalPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          moneyDescriptionContainerItem(
            context,
            '${multiplyCount.toDouble()} ₺',
          ),
          SizedBox(
            width: context.width / 4,
            height: context.normalValue * 3,
            child: buildTextFieldItem(
              BrokenStrings.instance.moneyGramTitle,
              controller: gramController,
              onChanged: (value) => cubit.gramToCount(
                stringGram: value,
                bolunecekGram: divideGram,
                countController: countController,
                carpilacakMoney: multiplyCount,
                resultController: resultController,
              ),
            ),
          ),
          SizedBox(
            width: context.width / 4,
            height: context.normalValue * 3,
            child: buildTextFieldItem(
              BrokenStrings.instance.moneyCountTitle,
              controller: countController,
              onChanged: (String value) => cubit.countToGram(
                resultController: resultController,
                carpilacakGram: divideGram,
                carpilacakMoney: multiplyCount,
                gramController: gramController,
                stringCount: value,
              ),
            ),
          ),
          buildExportMoneyItem(context, resultController.text),
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
              BrokenStrings.instance.moneyCategoryTitle,
              context.highValue,
              isColor: true,
            ),
            descriptionTitlesItem(
              context,
              BrokenStrings.instance.moneyGramTitle,
              context.highValue * 1.5,
            ),
            descriptionTitlesItem(
              context,
              BrokenStrings.instance.moneyCountTitle,
              context.highValue * 1.5,
            ),
            descriptionTitlesItem(
              context,
              BrokenStrings.instance.moneyResultTitle,
              context.highValue,
              isColor: true,
            ),
          ],
        ),
      );
    });
  }

  Container moneyDescriptionContainerItem(BuildContext context, String title) {
    return Container(
      width: context.width / 5,
      height: context.normalValue * 3,
      padding: context.paddingLow,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: context.colorScheme.primary,
          width: 2,
        ),
      ),
      child: Center(child: Text(title)),
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

  Container buildExportMoneyItem(BuildContext context, String money) {
    return Container(
      width: context.width / 5,
      height: context.normalValue * 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Center(child: Text('$money ₺')),
    );
  }

  Widget descriptionTitlesItem(BuildContext context, String title, double width,
      {bool isColor = false}) {
    return SizedBox(
      width: context.width / 4,
      height: context.normalValue * 3,
      child: Center(
        child: Text(
          title,
          style: context.textTheme.titleSmall?.copyWith(
            color: isColor ? context.colorScheme.primary : null,
          ),
        ),
      ),
    );
  }
}
