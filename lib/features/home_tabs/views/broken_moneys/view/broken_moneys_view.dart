import '../../../../../core/components/button/custom_elevated_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/money_grams.dart';
import '../../../../../core/constants/strings/broken_strings.dart';
import '../../../../../core/constants/strings/project_strings.dart';
import '../../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import '../../../../../core/models/broken_money_model.dart';
import '../../../../../product/ads_banner/view/ads_view.dart';
import '../../../../../product/drawer/view/custom_drawer_view.dart';
import '../../broken_money_add/view/broken_money_add_view.dart';

class BrokenMoneys extends StatelessWidget {
  BrokenMoneys({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          BrokenStrings.instance.pageTitle,
          style: context.general.textTheme.titleLarge?.copyWith(
            color: context.general.colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: context.general.colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<BrokenMoneyModel>(
                ProjectStrings.instance.brokenMoneyBoxTitle,
              ).listenable(),
              builder: (context, Box<BrokenMoneyModel> box, _) {
                if (box.isEmpty) {
                  return buildEmptyMessage(context);
                } else {
                  final list = box.values.toList().reversed.toList();
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: context.padding.horizontalLow,
                          children: List.generate(
                            list.length,
                            (index) => buildCard(
                              context,
                              list[index],
                              box,
                              index,
                              (list.length - 1 - index),
                            ),
                          ),
                        ),
                      ),
                      const AdsBanner(),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: buildNavigateButton(context),
    );
  }

  Center buildEmptyMessage(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.boxOpen,
          color: context.general.colorScheme.primary,
          size: context.sized.width * .3,
        ),
        context.sized.emptySizedHeightBoxLow3x,
        Text(
          BrokenStrings.instance.emptyBoxMessage,
          style: context.general.textTheme.bodyLarge?.copyWith(
            color: context.general.colorScheme.primary,
          ),
        ),
      ],
    ));
  }

  Card buildCard(
    BuildContext context,
    BrokenMoneyModel? model,
    Box<BrokenMoneyModel> box,
    int index,
    int reversedIndex,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: context.border.lowBorderRadius,
      ),
      child: ExpansionTile(
        childrenPadding: context.padding.low,
        shape: RoundedRectangleBorder(
          borderRadius: context.border.lowBorderRadius,
        ),
        title: buildDateTitle(context, model),
        children: [
          buildDateAndDeleteTitle(context, model, box, reversedIndex),
          buildDescriptionTitles(),
          buildRow(
            context,
            divideGram: MoneyGrams.money1Grams,
            multiplyCount: BrokenMoneyCounts.moneyCount1,
            money: model?.brokenMoney_1 ?? 0,
          ),
          buildRow(
            context,
            divideGram: MoneyGrams.money050Grams,
            multiplyCount: BrokenMoneyCounts.moneyCount050,
            money: model?.brokenMoney_050 ?? 0,
          ),
          buildRow(
            context,
            divideGram: MoneyGrams.money025Grams,
            multiplyCount: BrokenMoneyCounts.moneyCount025,
            money: model?.brokenMoney_025 ?? 0,
          ),
          buildRow(
            context,
            divideGram: MoneyGrams.money010Grams,
            multiplyCount: BrokenMoneyCounts.moneyCount010,
            money: model?.brokenMoney_010 ?? 0,
          ),
          buildRow(
            context,
            divideGram: MoneyGrams.money005Grams,
            multiplyCount: BrokenMoneyCounts.moneyCount005,
            money: model?.brokenMoney_005 ?? 0,
          ),
        ],
      ),
    );
  }

  Widget buildNavigateButton(BuildContext context) {
    return CustomElevatedTextButton(
      onPressed: () => context.route.navigateToPage(const BrokenMoneyAddView()),
      title: BrokenStrings.instance.fabTitle,
    );
  }

  Widget buildDateAndDeleteTitle(
    BuildContext context,
    BrokenMoneyModel? model,
    Box<BrokenMoneyModel> box,
    int deletedIndex,
  ) {
    return ListTile(
      title: buildDateTitle(context, model),
      trailing: CustomIconButton(
        iconData: Icons.delete,
        color: context.general.colorScheme.primary,
        onTap: () {
          box.deleteAt(deletedIndex).whenComplete(() {
            scaffoldKey.showGreatSnackBar(
              'Hesaplama Silindi | ${formatAmount(model?.totalMoney ?? 0)}₺',
            );
          });
        },
        toolTip: BrokenStrings.instance.deleteButtomTitle,
      ),
    );
  }

  Padding buildDateTitle(BuildContext context, BrokenMoneyModel? model) {
    return Padding(
      padding: context.padding.verticalLow,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '${model?.date ?? ''}\n'),
            TextSpan(
              text: '${formatAmount(model?.totalMoney ?? 0)}₺',
              style: context.general.textTheme.bodyLarge?.copyWith(
                color: context.general.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(
    BuildContext context, {
    required double multiplyCount,
    required double divideGram,
    required double money,
  }) {
    final count = money / multiplyCount;
    final gram = count * divideGram;
    if (money == 0) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: context.padding.verticalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          moneyDescriptionContainerItem(context, '$multiplyCount₺'),
          moneyDescriptionContainerItem(context, '$gram', isColor: true),
          moneyDescriptionContainerItem(context, '$count', isColor: true),
          moneyDescriptionContainerItem(context, '$money₺', isColor: true),
        ],
      ),
    );
  }

  Widget descriptionTitlesItem(BuildContext context, String title, double width,
      {bool isColor = false}) {
    return SizedBox(
      width: width,
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

  Container moneyDescriptionContainerItem(BuildContext context, String title,
      {bool isColor = false}) {
    return Container(
      width: context.sized.width / 6,
      height: context.sized.normalValue * 3,
      padding: context.padding.low,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isColor
              ? context.general.colorScheme.error
              : context.general.colorScheme.primary,
          width: 2,
        ),
      ),
      child: Center(
          child: Text(
        title,
        maxLines: 1,
      )),
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
              BrokenStrings.instance.moneyCategoryTitle,
              context.sized.highValue,
              isColor: true,
            ),
            descriptionTitlesItem(
              context,
              BrokenStrings.instance.moneyGramTitle,
              context.sized.highValue,
            ),
            descriptionTitlesItem(
              context,
              BrokenStrings.instance.moneyCountTitle,
              context.sized.highValue,
            ),
            descriptionTitlesItem(
              context,
              BrokenStrings.instance.moneyResultTitle,
              context.sized.highValue,
              isColor: true,
            ),
          ],
        ),
      );
    });
  }

  String formatAmount(double price) =>
      NumberFormat("#,##0.00", "tr_TR").format(price);
}
