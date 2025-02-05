import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NChipTheme {
  NChipTheme._();
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: NColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: NColors.black),
    selectedColor: NColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: NColors.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: NColors.darkerGrey,
    labelStyle: const TextStyle(color: NColors.white),
    selectedColor: NColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: NColors.white,
  );
}
