import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomCircleIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;

  const CustomCircleIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.border.highBorderRadius,
      onTap: onTap,
      child: Container(
        padding: context.padding.low * .3,
        decoration: BoxDecoration(
          border: Border.all(
            color: iconColor ?? Colors.white,
            width: context.sized.lowValue * .3,
          ),
          shape: BoxShape.circle,
          color: backgroundColor ?? Colors.blue,
        ),
        child: Icon(
          iconData,
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}
