import 'package:calculate_broken_money/product/ads_banner/view/ads_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../core/constants/colors/color_constants.dart';
import '../../../cubit/main_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomDrawerCubit>();
    final mainCubit = context.read<MainCubit>();
    return Drawer(
      child: Padding(
        padding: context.padding.horizontalLow,
        child: Column(
          children: [
            context.sized.emptySizedHeightBoxNormal,
            const ListTile(
              title: Text('Renk Seçeneği'),
              leading: Icon(Icons.color_lens),
            ),
            BlocBuilder<CustomDrawerCubit, CustomDrawerState>(
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
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: context.border.lowBorderRadius,
                          side: state.colorIndex == index
                              ? const BorderSide(
                                  color: Colors.black,
                                )
                              : BorderSide.none,
                        ),
                        color: ColorConstants.instance.allColor[index],
                      ),
                    );
                  },
                );
              },
            ),
            BlocBuilder<CustomDrawerCubit, CustomDrawerState>(
              builder: (context, state) {
                return SwitchListTile(
                  value: state.isDarkMode ?? false,
                  onChanged: (value) async {
                    await cubit.setDarkMode(value);
                    await mainCubit.getColorSettings();
                  },
                  title: const Text('Koyu Mod'),
                );
              },
            ),
            const Spacer(),
            const AdsBanner(),
          ],
        ),
      ),
    );
  }
}
