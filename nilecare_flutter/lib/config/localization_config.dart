import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationConfig {
  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('am', 'ET'),
  ];

  static const fallbackLocale = Locale('en', 'US');
  static const path = 'assets/translations';

  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }

  static String translate(String key) {
    return key.tr();
  }

  static Future<void> setLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  static Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  static bool isAmharic(BuildContext context) {
    return getCurrentLocale(context).languageCode == 'am';
  }

  static bool isEnglish(BuildContext context) {
    return getCurrentLocale(context).languageCode == 'en';
  }
}
