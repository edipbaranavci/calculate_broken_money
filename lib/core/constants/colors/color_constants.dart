import 'package:flutter/material.dart';

class ColorConstants {
  static ColorConstants? _instance;
  // Avoid self instance
  ColorConstants._();
  static ColorConstants get instance => _instance ??= ColorConstants._();

  final String colorConstantsKey = 'ColorConstantsKey';
  final String colorConstantsDarkModeKey = 'ColorConstantsDarkModeKey';
  final List<Color> allColor = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.brown,
    Colors.blue,
    Colors.grey,
    Colors.cyan,
    Colors.pink,
    Colors.teal,
  ];
}
