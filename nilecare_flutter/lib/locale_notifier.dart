import 'package:flutter/material.dart';

class LocaleNotifier extends ChangeNotifier {
  Locale _currentLocale = const Locale('en'); // default

  Locale get currentLocale => _currentLocale;

  void changeLocale(Locale newLocale) {
    if (_currentLocale == newLocale) return;
    _currentLocale = newLocale;
    notifyListeners();
  }
}
