import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:intl/intl.dart';

import '../../../../../core/components/button/custom_elevated_text_button.dart';
import '../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/strings/paper_strings.dart';
import '../../../../../core/constants/strings/project_strings.dart';
import '../../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import '../../../../../core/models/paper_money_model.dart';
import '../../../../../product/ads_banner/view/ads_view.dart';
import '../../../../../product/drawer/view/custom_drawer_view.dart';
import '../../paper_money_add/view/paper_money_add_view.dart';

class PaperMoneys extends StatelessWidget {
  PaperMoneys({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: context.general.colorScheme.primary,
        title: Text(
          PaperStrings.instance.pageTitle,
          style: context.general.textTheme.titleLarge?.copyWith(
            color: context.general.colorScheme.onPrimary,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<PaperMoneyModel>(
          ProjectStrings.instance.paperMoneyBoxTitle,
        ).listenable(),
        builder: (context, Box<PaperMoneyModel> box, _) {
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
                      (index) => buildCard(context, list[index], box, index,
                          (list.length - 1 - index)),
                    ),
                  ),
                ),
                const AdsBanner(),
              ],
            );
          }
        },
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
          size: context.sized.width * .3,
          color: context.general.colorScheme.primary,
        ),
        context.sized.emptySizedHeightBoxLow3x,
        Text(
          PaperStrings.instance.emptyBoxMessage,
          style: context.general.textTheme.bodyLarge?.copyWith(
            color: context.general.colorScheme.primary,
          ),
        ),
      ],
    ));
  }

  Card buildCard(
    BuildContext context,
    PaperMoneyModel? model,
    Box<PaperMoneyModel> box,
    int index,
    int reversedIndex,
  ) {
    return Card(
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: context.border.lowBorderRadius,
        ),
        childrenPadding: context.padding.low,
        title: buildDateTitle(context, model),
        children: [
          buildDateAndDeleteTitle(context, model, box, reversedIndex),
          buildDescriptionTitles(),
          buildRow(
            context,
            multiplyCount: PaperMoneyCounts.moneyCount5,
            money: model?.papaperMoney5 ?? 0,
          ),
          buildRow(
            context,
            multiplyCount: PaperMoneyCounts.moneyCount10,
            money: model?.papaperMoney10 ?? 0,
          ),
          buildRow(
            context,
            multiplyCount: PaperMoneyCounts.moneyCount20,
            money: model?.papaperMoney20 ?? 0,
          ),
          buildRow(
            context,
            multiplyCount: PaperMoneyCounts.moneyCount50,
            money: model?.papaperMoney50 ?? 0,
          ),
          buildRow(
            context,
            multiplyCount: PaperMoneyCounts.moneyCount100,
            money: model?.papaperMoney100 ?? 0,
          ),
          buildRow(
            context,
            multiplyCount: PaperMoneyCounts.moneyCount200,
            money: model?.papaperMoney200 ?? 0,
          )
        ],
      ),
    );
  }

  Widget buildRow(
    BuildContext context, {
    required int multiplyCount,
    required int money,
  }) {
    final count = money ~/ multiplyCount;
    if (money == 0) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: context.padding.verticalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          moneyDescriptionContainerItem(
            context,
            '$multiplyCount₺',
            width: context.sized.width / 4,
          ),
          moneyDescriptionContainerItem(
            context,
            '$count',
            isColor: true,
            width: context.sized.width / 4,
          ),
          moneyDescriptionContainerItem(
            context,
            '$money₺',
            isColor: true,
            width: context.sized.width / 4,
          ),
        ],
      ),
    );
  }

  Widget buildDateAndDeleteTitle(
    BuildContext context,
    PaperMoneyModel? model,
    Box<PaperMoneyModel> box,
    int deletedIndex,
  ) {
    return ListTile(
      title: buildDateTitle(context, model),
      trailing: CustomIconButton(
        iconData: Icons.delete,
        color: context.general.colorScheme.primary,
        toolTip: PaperStrings.instance.deleteButtomTitle,
        onTap: () {
          box.deleteAt(deletedIndex).whenComplete(() {
            scaffoldKey.showGreatSnackBar(
              'Hesaplama Silindi | ${formatAmount(model?.totalMoney ?? 0)}₺',
            );
          });
        },
      ),
    );
  }

  Padding buildDateTitle(BuildContext context, PaperMoneyModel? model) {
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
              context.sized.highValue,
              isColor: true,
            ),
            descriptionTitlesItem(context,
                PaperStrings.instance.moneyCountTitle, context.sized.highValue),
            descriptionTitlesItem(
              context,
              PaperStrings.instance.moneyResultTitle,
              context.sized.highValue,
              isColor: true,
            ),
          ],
        ),
      );
    });
  }

  Widget buildNavigateButton(BuildContext context) {
    return CustomElevatedTextButton(
      onPressed: () => context.route.navigateToPage(const PaperMoneyAddView()),
      title: PaperStrings.instance.fabTitle,
    );
  }

  Widget descriptionTitlesItem(BuildContext context, String title, double width,
      {bool isColor = false}) {
    return SizedBox(
      width: width,
      height: context.sized.highValue * 0.2,
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
      {bool isColor = false, required double width}) {
    return Container(
      width: width,
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
      child: Center(child: Text(title, maxLines: 1)),
    );
  }

  String formatAmount(int price) =>
      NumberFormat("#,##0", "tr_TR").format(price);
}
