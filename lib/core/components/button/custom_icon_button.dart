import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final Color? color;
  final double? size;
  final String? toolTip;
  final EdgeInsets? padding;
  const CustomIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
    this.color,
    this.size,
    this.toolTip,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.border.lowBorderRadius,
      splashColor: color?.withOpacity(.6),
      onTap: onTap,
      child: Tooltip(
        message: toolTip ?? '',
        child: Padding(
          padding: padding ?? context.padding.low,
          child: Icon(
            iconData,
            size: size,
            color: color ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
