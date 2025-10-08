import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nile_care/cubit/language_cubit.dart';
import 'package:nile_care/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // for context.watch/read
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final currentLocale = context.watch<LanguageCubit>().state.languageCode;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;

    String getLanguageLabel(String code) {
      switch (code) {
        case 'am':
          return 'አማርኛ';
        case 'or':
          return 'Afaan Oromoo';
        case 'en':
        default:
          return 'English';
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      const AssetImage('assets/avatar_placeholder.png'),
                  // Or NetworkImage if you have user photo URL
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nathaniel Abayneh', // You can make this dynamic later
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'nathaniel@example.com', // dynamic user email later
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {
                    // TODO: Navigate to Edit Profile page
                  },
                  tooltip: AppLocalizations.of(context)!.editProfile,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Appearance Section
            Text(
              AppLocalizations.of(context)!.appearance,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    title: Text(AppLocalizations.of(context)!.darkMode),
                    value: themeNotifier.isDarkMode,
                    onChanged: (_) => themeNotifier.toggleTheme(),
                    secondary: const Icon(Icons.dark_mode_outlined),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: const Icon(Icons.language_outlined),
                    title: Text(AppLocalizations.of(context)!.language),
                    subtitle: Text(getLanguageLabel(currentLocale)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        builder: (_) => const LanguageSelector(),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Privacy & Notifications Section
            Text(
              AppLocalizations.of(context)!.privacySettings,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: Text(AppLocalizations.of(context)!.privacySettings),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: Text(
                        AppLocalizations.of(context)!.notificationSettings),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(AppLocalizations.of(context)!.about),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Center(
              child: Text(
                'Version 1.0.0',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.read<LanguageCubit>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('English'),
            onTap: () {
              languageCubit.changeLanguage(const Locale('en'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('አማርኛ'),
            onTap: () {
              languageCubit.changeLanguage(const Locale('am'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Afaan Oromoo'),
            onTap: () {
              languageCubit.changeLanguage(const Locale('or'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
