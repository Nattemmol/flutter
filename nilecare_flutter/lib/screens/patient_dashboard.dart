import 'package:flutter/material.dart';
import 'package:nile_care/models/patient.dart';
import 'package:nile_care/models/appointment.dart';
import 'package:nile_care/services/patient_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientDashboard extends StatefulWidget {
  final String patientId; // we need this to fetch data

  const PatientDashboard({super.key, required this.patientId});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  int _selectedIndex = 0;
  final PatientService _patientService = PatientService();

  late Future<Patient> _patientFuture;
  late Future<List<Appointment>> _appointmentsFuture;
  late Future<List<Map<String, dynamic>>> _medicalRecordsFuture;

  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  void _loadPatientData() {
    _patientFuture = _patientService.getPatientProfile(widget.patientId);
    _appointmentsFuture =
        _patientService.getPatientAppointments(widget.patientId);
    _medicalRecordsFuture =
        _patientService.getMedicalRecords(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildProfilePage(),
      _buildAppointmentsPage(),
      _buildChatPage(),
      _buildSettingsPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.person_outline),
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

  /// ---------------- Profile Page ----------------
  Widget _buildProfilePage() {
    return FutureBuilder<Patient>(
      future: _patientFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No profile data found"));
        }

        final patient = snapshot.data!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: patient.profileImage != null
                    ? NetworkImage(patient.profileImage!)
                    : null,
                child: patient.profileImage == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
              const SizedBox(height: 20),
              Text(
                patient.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(patient.email, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(patient.phoneNumber),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(patient.address ?? "No address provided"),
              ),
              ListTile(
                leading: const Icon(Icons.medical_information),
                title: const Text("Medical History"),
                subtitle: Text(patient.medicalHistory.join(", ")),
              ),
              ListTile(
                leading: const Icon(Icons.warning_amber),
                title: const Text("Allergies"),
                subtitle: Text(patient.allergies.join(", ")),
              ),
              ListTile(
                leading: const Icon(Icons.local_hospital),
                title: const Text("Medications"),
                subtitle: Text(patient.medications.join(", ")),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ---------------- Appointments Page ----------------
  Widget _buildAppointmentsPage() {
    return FutureBuilder<List<Appointment>>(
      future: _appointmentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No appointments found"));
        }

        final appointments = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appt = appointments[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: Text("Doctor: ${appt.doctorName}"),
                subtitle: Text(
                    "${appt.date.toLocal()} at ${appt.time} - Status: ${appt.status}"),
              ),
            );
          },
        );
      },
    );
  }

  /// ---------------- Chat Page ----------------
  Widget _buildChatPage() {
    return const Center(
      child: Text("Chat feature coming soon..."),
    );
  }

  /// ---------------- Settings Page ----------------
  Widget _buildSettingsPage() {
    return const Center(
      child: Text("Settings coming soon..."),
    );
  }
}
