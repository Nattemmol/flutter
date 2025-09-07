import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nile_care/cubit/language_cubit.dart';
import 'package:nile_care/locale_notifier.dart';
import 'package:nile_care/screens/appointments_screen.dart';
import 'package:nile_care/screens/login_screen.dart';
import 'package:nile_care/screens/patient_dashboard.dart';
import 'package:nile_care/screens/signup_screen.dart';
import 'package:nile_care/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: BlocProvider(
        create: (_) => LanguageCubit(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          locale: locale,
          supportedLocales: const [
            Locale('en'), // English
            Locale('am'), // Amharic
            Locale('or'), //Afaan Oromo
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:
              themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const PatientDashboard(),
        );
      },
    );
  }
}
