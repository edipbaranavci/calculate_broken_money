import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../core/constants/colors/color_constants.dart';
import '../../../cubit/main_cubit.dart';
import '../../ads_banner/view/ads_view.dart';
import '../cubit/custom_drawer_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomDrawerCubit>(
      create: (context) => CustomDrawerCubit(),
      child: const _CustomDrawer(),
    );
  }
}

class _CustomDrawer extends StatelessWidget {
  const _CustomDrawer();
  final String colorsTitle = 'Renk Seçeneği';
  final String darkModeTitle = 'Koyu Mod';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomDrawerCubit>();
    final mainCubit = context.read<MainCubit>();
    return Drawer(
      backgroundColor: context.general.appTheme.colorScheme.primary,
      child: Padding(
        padding: context.padding.horizontalLow,
        child: Column(
          children: [
            context.sized.emptySizedHeightBoxNormal,
            buildColorsTitleCard(),
            buildColorCards(cubit, mainCubit),
            buildDarkModeSwitchButton(mainCubit),
            const Spacer(),
            const AdsBanner(),
          ],
        ),
      ),
    );
  }

  Card buildColorsTitleCard() {
    return Card(
      child: ListTile(
        title: Text(colorsTitle),
        leading: const Icon(Icons.color_lens),
      ),
    );
  }

  Widget buildColorCards(CustomDrawerCubit cubit, MainCubit mainCubit) {
    return BlocBuilder<CustomDrawerCubit, CustomDrawerState>(
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemCount: ColorConstants.instance.allColor.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                await cubit.setColor(index);
                await mainCubit.getColorSettings();
              },
              borderRadius: context.border.lowBorderRadius,
              child: buildColorCard(
                state.colorIndex == index,
                ColorConstants.instance.allColor[index],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildColorCard(bool isBlackBorder, Color? color) {
    return Builder(builder: (context) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: context.border.lowBorderRadius,
          side: isBlackBorder
              ? const BorderSide(
                  color: Colors.black,
                )
              : BorderSide.none,
        ),
        color: color,
      );
    });
  }

  Widget buildDarkModeSwitchButton(MainCubit mainCubit) {
    return BlocBuilder<CustomDrawerCubit, CustomDrawerState>(
      builder: (context, state) {
        final cubit = context.read<CustomDrawerCubit>();
        return Card(
          child: SwitchListTile(
            value: state.isDarkMode ?? false,
            onChanged: (value) async {
              await cubit.setDarkMode(value);
              await mainCubit.getColorSettings();
            },
            secondary: Icon(
              Icons.format_color_fill_sharp,
              color: context.general.colorScheme.primary,
            ),
            title: Text(darkModeTitle),
          ),
        );
      },
    );
  }
}
