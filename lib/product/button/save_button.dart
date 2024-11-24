import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, this.onPressed, required this.title});

  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.general.colorScheme.primary,
        iconColor: context.general.colorScheme.onPrimary,
      ),
      label: Padding(
        padding: context.padding.normal,
        child: Text(
          title,
          style: context.general.textTheme.titleSmall?.copyWith(
            color: context.general.colorScheme.onPrimary,
          ),
        ),
      ),
      icon: const Icon(Icons.save),
    );
  }
}
