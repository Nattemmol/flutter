import 'package:flutter/material.dart';
import 'package:nile_care/screens/appointments_screen.dart';
import 'package:nile_care/screens/dashboard.dart';
import 'package:nile_care/screens/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _HomeViewState();
}

class _HomeViewState extends State<PatientDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    AppointmentBookingScreen(),
    ChatPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              label: AppLocalizations.of(context)!.home),
          NavigationDestination(
              icon: const Icon(Icons.calendar_month_outlined),
              label: AppLocalizations.of(context)!.appointments),
          NavigationDestination(
              icon: const Icon(Icons.chat_bubble_outline),
              label: AppLocalizations.of(context)!.chat),
          NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              label: AppLocalizations.of(context)!.settings),
        ],
      ),
    );
  }
}

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Appointments Page - Coming Soon'),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Chat Page - Coming Soon'),
    );
  }
}
