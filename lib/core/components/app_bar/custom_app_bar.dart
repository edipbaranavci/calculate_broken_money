import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../button/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final VoidCallback? onBackTap;

  const CustomAppBar({
    super.key,
    this.onBackTap,
    required this.title,
  }) : preferredSize = const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: context.general.textTheme.titleLarge),
      centerTitle: true,
      leading: Center(
        child: CustomIconButton(
          iconData: Icons.chevron_left,
          color: context.general.colorScheme.primary,
          onTap: onBackTap ?? () => context.route.pop(),
          toolTip: 'Geri',
        ),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
