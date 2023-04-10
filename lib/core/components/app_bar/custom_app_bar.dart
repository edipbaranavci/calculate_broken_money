import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../button/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final VoidCallback? onBackTap;

  CustomAppBar({
    Key? key,
    this.onBackTap,
    required this.title,
  })  : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: context.textTheme.titleLarge),
      centerTitle: true,
      leading: Center(
        child: CustomIconButton(
          iconData: Icons.chevron_left,
          onTap: onBackTap ?? () => context.pop(),
          toolTip: 'Geri',
        ),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
