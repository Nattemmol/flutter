import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nile_care/cubit/language_cubit.dart';
import 'package:nile_care/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AuthService _authService;
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _authService.getCurrentUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error, show snackbar or fallback
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateProfileName(String name) async {
    if (_user == null) return;
    setState(() => _isLoading = true);
    try {
      final updatedUser = await _authService.updateProfile(name: name);
      setState(() {
        _user = updatedUser;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update name')));
    }
  }

  Future<void> _updateProfileImage() async {
    if (_user == null) return;
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile == null) return;

    setState(() => _isLoading = true);
    try {
      final updatedUser =
          await _authService.updateProfile(profileImage: pickedFile.path);
      setState(() {
        _user = updatedUser;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update image')));
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final currentLocale = context.watch<LanguageCubit>().state.languageCode;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _user?.profileImage != null
                            ? FileImage(File(_user!.profileImage!))
                            : const AssetImage('assets/avatar_placeholder.png')
                                as ImageProvider,
                        backgroundColor: Colors.grey[300],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user?.name ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _user?.email ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blueAccent),
                        onPressed: () async {
                          final newName = await showDialog<String>(
                            context: context,
                            builder: (context) {
                              final controller = TextEditingController(
                                  text: _user?.name ?? '');
                              return AlertDialog(
                                title: const Text('Edit Name'),
                                content: TextField(
                                  controller: controller,
                                  decoration:
                                      const InputDecoration(hintText: 'Name'),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, null),
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, controller.text),
                                      child: const Text('Save')),
                                ],
                              );
                            },
                          );
                          if (newName != null && newName.isNotEmpty) {
                            _updateProfileName(newName);
                          }
                        },
                        tooltip: AppLocalizations.of(context)!.editProfile,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _updateProfileImage,
                    child: const Text('Change Profile Image'),
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
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          title: Text(AppLocalizations.of(context)!.darkMode),
                          value: themeNotifier.isDarkMode,
                          onChanged: (_) => themeNotifier.toggleTheme(),
                          secondary: const Icon(Icons.dark_mode_outlined),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          leading: const Icon(Icons.language_outlined),
                          title: Text(AppLocalizations.of(context)!.language),
                          subtitle: Text(getLanguageLabel(currentLocale)),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25)),
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
                          title:
                              Text(AppLocalizations.of(context)!.privacySettings),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.notifications_outlined),
                          title: Text(
                              AppLocalizations.of(context)!.notificationSettings),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: Text(AppLocalizations.of(context)!.about),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () async {
                            await _authService.logout();
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/login', (r) => false);
                          },
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
