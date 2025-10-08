import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/patient_service.dart';
import '../../services/appointment_service.dart';
import '../../models/patient.dart';
import '../../models/appointment.dart';

class DoctorPatientsPage extends StatefulWidget {
  final String doctorId;
  const DoctorPatientsPage({super.key, required this.doctorId});

  @override
  State<DoctorPatientsPage> createState() => _DoctorPatientsPageState();
}

class _DoctorPatientsPageState extends State<DoctorPatientsPage> {
  final PatientService _patientService = PatientService();
  final AppointmentService _appointmentService = AppointmentService();

  bool _isLoading = true;
  String? _errorMessage;
  List<Patient> _patients = [];
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchPatientsAndAppointments();
  }

  Future<void> _fetchPatientsAndAppointments() async {
    try {
      // Fetch all doctor appointments
      final appointments =
          await _appointmentService.getDoctorAppointments(widget.doctorId);

      // Extract patient IDs from appointments
      final patientIds =
          appointments.map((appt) => appt.patientId).toSet().toList();

      // Fetch each patient profile
      final patients = <Patient>[];
      for (var id in patientIds) {
        final patient = await _patientService.getPatientProfile(id);
        patients.add(patient);
      }

      setState(() {
        _appointments = appointments;
        _patients = patients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patients",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? const Color(0xFF2A2D3E) : const Color(0xFF336699),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : RefreshIndicator(
                  onRefresh: _fetchPatientsAndAppointments,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Header Banner ---
                        _headerBanner(isDark),

                        const SizedBox(height: 20),

                        // --- Patient Stats Section ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _statCard(
                              _patients.length.toString(),
                              "Active",
                              Icons.person,
                              isDark,
                            ),
                            _statCard(
                              _patients
                                  .where((p) =>
                                      p.healthStatus?.toLowerCase() ==
                                      "critical")
                                  .length
                                  .toString(),
                              "Critical",
                              Icons.warning,
                              isDark,
                            ),
                            _statCard(
                              _appointments
                                  .where((a) =>
                                      a.status?.toLowerCase() == "upcoming")
                                  .length
                                  .toString(),
                              "Upcoming Appts",
                              Icons.schedule,
                              isDark,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // --- Helpful Banner ---
                        _helpfulBanner(isDark),
                        const SizedBox(height: 24),

                        // --- Patients List ---
                        Text(
                          "Patient List",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        if (_patients.isEmpty)
                          Center(
                            child: Text(
                              "No patients found",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isDark
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          )
                        else
                          Column(
                            children: _patients.map((patient) {
                              final lastVisit = _appointments
                                  .where((a) =>
                                      a.patientId == patient.id &&
                                      a.status == "completed")
                                  .map((a) => a.date)
                                  .toList()
                                ..sort();
                              final nextAppt = _appointments
                                  .where((a) =>
                                      a.patientId == patient.id &&
                                      a.status == "upcoming")
                                  .map((a) => a.date)
                                  .toList()
                                ..sort();

                              return _patientCard(
                                context,
                                name: patient.name ?? "Unknown",
                                age: patient.age ?? 0,
                                lastVisit: lastVisit.isNotEmpty
                                    ? lastVisit.last.toString()
                                    : "N/A",
                                nextAppointment: nextAppt.isNotEmpty
                                    ? nextAppt.first.toString()
                                    : "N/A",
                                healthStatus:
                                    patient.healthStatus ?? "Unknown",
                              );
                            }).toList(),
                          ),

                        const SizedBox(height: 24),

                        // --- Tips Section ---
                        Text(
                          "Tips & Reminders",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _tipCard("Always check patient history.", isDark),
                        _tipCard("Review critical patients daily.", isDark),
                        _tipCard("Keep contact info updated.", isDark),
                      ],
                    ),
                  ),
                ),
    );
  }

  // --- Header Banner ---
  Widget _headerBanner(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF4A4E69), const Color(0xFF22223B)]
              : [const Color(0xFF336699), const Color(0xFF5C7AEA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Patients",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Manage and view patient info",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // --- Stat Card ---
  Widget _statCard(String number, String title, IconData icon, bool isDark) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2D3E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: isDark ? Colors.white : const Color(0xFF336699)),
            const SizedBox(height: 8),
            Text(
              number,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helpful Banner ---
  Widget _helpfulBanner(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3E) : Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.health_and_safety_outlined, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Remember to review critical patients' latest reports daily.",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Patient Card ---
  Widget _patientCard(
    BuildContext context, {
    required String name,
    required int age,
    required String lastVisit,
    required String nextAppointment,
    required String healthStatus,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    switch (healthStatus.toLowerCase()) {
      case "critical":
        statusColor = Colors.redAccent;
        break;
      case "under observation":
        statusColor = Colors.orangeAccent;
        break;
      default:
        statusColor = Colors.greenAccent;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Age: $age | Health: $healthStatus",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Last Visit: $lastVisit | Next Appt: $nextAppointment",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isDark ? Colors.white38 : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: healthStatus.toLowerCase() == "critical"
                ? 0.25
                : healthStatus.toLowerCase() == "under observation"
                    ? 0.5
                    : 0.85,
            backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(statusColor),
          ),
        ],
      ),
    );
  }

  // --- Tip Card ---
  Widget _tipCard(String text, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline,
              color: isDark ? Colors.white70 : const Color(0xFF336699)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
