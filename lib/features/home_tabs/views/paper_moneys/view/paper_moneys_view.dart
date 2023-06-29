import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/components/button/custom_icon_button.dart';
import '../../../../../core/extensions/scaffold_messenger/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';

import '../../../../../core/constants/money_counts.dart';
import '../../../../../core/constants/strings/paper_strings.dart';
import '../../../../../core/constants/strings/project_strings.dart';
import '../../../../../core/models/paper_money_model.dart';
import '../../paper_money_add/view/paper_money_add_view.dart';

class PaperMoneys extends StatelessWidget {
  PaperMoneys({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<PaperMoneyModel>(
          ProjectStrings.instance.paperMoneyBoxTitle,
        ).listenable(),
        builder: (context, Box<PaperMoneyModel> box, _) {
          if (box.isEmpty) {
            return Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.boxOpen,
                  size: context.width * .3,
                ),
                context.emptySizedHeightBoxLow3x,
                Text(
                  PaperStrings.instance.emptyBoxMessage,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ));
          } else {
            return Padding(
              padding: context.paddingNormal,
              child: ListView.builder(
                itemCount: box.values.length,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) =>
                    buildCard(context, box.getAt(index), box, index),
              ),
            );
          }
        },
      ),
      floatingActionButton: buildNavigateButton(context),
    );
  }

  Card buildCard(BuildContext context, PaperMoneyModel? model,
      Box<PaperMoneyModel> box, int index) {
    return Card(
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: context.lowBorderRadius,
        ),
        childrenPadding: context.paddingLow,
        title: buildDateTitle(context, model),
        children: [
          buildDateAndDeleteTitle(context, model, box, index),
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
          ),
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
    return Padding(
      padding: context.verticalPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          moneyDescriptionContainerItem(
            context,
            '$multiplyCount₺',
            width: context.width / 4,
          ),
          moneyDescriptionContainerItem(
            context,
            '$count',
            isColor: true,
            width: context.width / 4,
          ),
          moneyDescriptionContainerItem(
            context,
            '$money₺',
            isColor: true,
            width: context.width / 4,
          ),
        ],
      ),
    );
  }

  Widget buildDateAndDeleteTitle(BuildContext context, PaperMoneyModel? model,
      Box<PaperMoneyModel> box, int index) {
    return ListTile(
      title: buildDateTitle(context, model),
      trailing: CustomIconButton(
        iconData: Icons.delete,
        toolTip: PaperStrings.instance.deleteButtomTitle,
        onTap: () {
          box.deleteAt(index).whenComplete(() {
            scaffoldKey.showGreatSnackBar('Hesaplama Silindi!');
          });
        },
      ),
    );
  }

  Padding buildDateTitle(BuildContext context, PaperMoneyModel? model) {
    return Padding(
      padding: context.verticalPaddingLow,
      child: Text(
          '${model?.date ?? ''} - ${PaperStrings.instance.totalTitle}: ${model?.totalMoney ?? 0}₺'),
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
              context.highValue,
              isColor: true,
            ),
            descriptionTitlesItem(context,
                PaperStrings.instance.moneyCountTitle, context.highValue),
            descriptionTitlesItem(
              context,
              PaperStrings.instance.moneyResultTitle,
              context.highValue,
              isColor: true,
            ),
          ],
        ),
      );
    });
  }

  AppBar buildAppBar() =>
      AppBar(title: Text(PaperStrings.instance.pageTitle), centerTitle: true);

  ElevatedButton buildNavigateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.navigateToPage(const PaperMoneyAddView()),
      child: Text(PaperStrings.instance.fabTitle),
    );
  }

  Widget descriptionTitlesItem(BuildContext context, String title, double width,
      {bool isColor = false}) {
    return SizedBox(
      width: width,
      height: context.highValue * 0.2,
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

  Container moneyDescriptionContainerItem(BuildContext context, String title,
      {bool isColor = false, required double width}) {
    return Container(
      width: width,
      height: context.normalValue * 3,
      padding: context.paddingLow,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              isColor ? context.colorScheme.error : context.colorScheme.primary,
          width: 2,
        ),
      ),
      child: Center(child: Text(title, maxLines: 1)),
    );
  }
}
