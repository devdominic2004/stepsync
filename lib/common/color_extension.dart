import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color(0xFF92A3FD);
  static Color get primaryColor2 => const Color(0xFF9DCEFF);

  static Color get secondaryColor1 => const Color(0xFFC58BF2);
  static Color get secondaryColor2 => const Color(0xFFEEA4CE);

  static List<Color> get primaryG => [primaryColor2, primaryColor1];
  static List<Color> get secondaryG => [secondaryColor1, secondaryColor2];

  static Color get black => const Color(0xFF1D1617);
  static Color get gray => const Color(0xFF786F72);
  static Color get white => const Color(0xFFFFFFFF);
  static Color get lightGray => const Color(0xFFF7F8F8);
}
