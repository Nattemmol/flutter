import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Commented out due to missing file
import '../../l10n/app_localizations.dart';
import 'package:nile_care/screens/doctor%20dashboard/doctor_appointmentspage.dart';
import 'package:nile_care/screens/doctor%20dashboard/doctor_homepage.dart';
import 'package:nile_care/screens/doctor%20dashboard/doctor_patientspage.dart';
import 'package:nile_care/screens/settings.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DoctorHomePage(
      doctorId: "",
    ),
    DoctorAppointmentsPage(
      doctorId: "",
    ),
    DoctorPatientsPage(
      doctorId: "",
    ),
    //DoctorAvailabilityPageDemo(),
    SettingsPage()
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
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            label: AppLocalizations.of(context)!.appointments,
          ),
          const NavigationDestination(
              icon: Icon(Icons.people_alt_outlined), label: 'Patients'),
          const NavigationDestination(
              icon: Icon(Icons.schedule_outlined), label: 'Availability'),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}
