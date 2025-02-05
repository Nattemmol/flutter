import 'package:e_commerce_app/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';

class NAppTheme {
  NAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3:true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    chipTheme: NChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: NTextTheme.lightTextTheme,
    appBarTheme: NAppBarTheme.lightAppBarTheme,
    checkboxTheme: NCheckBoxTheme.lightCheckboxTheme,
    elevatedButtonTheme: NElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: NOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: NTextFormFieldTheme.lightInputDecorationTheme,

  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3:true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    chipTheme: NChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: NTextTheme.darkTextTheme,
    appBarTheme: NAppBarTheme.darkAppBarTheme,
    checkboxTheme: NCheckBoxTheme.darkCheckboxTheme,
    elevatedButtonTheme: NElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: NOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: NTextFormFieldTheme.darkInputDecorationTheme,

  );
}
