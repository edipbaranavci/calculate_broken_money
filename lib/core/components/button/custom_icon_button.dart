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
    Key? key,
    required this.iconData,
    required this.onTap,
    this.color,
    this.size,
    this.toolTip,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.lowBorderRadius,
      splashColor: color?.withOpacity(.6),
      onTap: onTap,
      child: Tooltip(
        message: toolTip ?? '',
        child: Padding(
          padding: padding ?? context.paddingLow,
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
