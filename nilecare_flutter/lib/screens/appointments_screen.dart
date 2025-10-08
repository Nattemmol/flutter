import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/appointment_service.dart';
import '../services/doctor_service.dart';
import '../services/specialties_service.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final Color lightPrimaryColor = const Color(0xFF1F2A44);
  final Color darkPrimaryColor = const Color(0xFF2A3A66);

  final AppointmentService _appointmentService = AppointmentService();
  final DoctorService _doctorService = DoctorService();
  final SpecialtiesService _specialtyService = SpecialtiesService();

  List<Map<String, dynamic>> _specialties = [];
  List<Doctor> _doctors = [];
  List<String> _timeSlots = [];

  String? selectedSpecialty;
  Doctor? selectedDoctor;
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  final TextEditingController noteController = TextEditingController();

  bool loadingSpecialties = true;
  bool loadingDoctors = false;
  bool loadingSlots = false;

  @override
  void initState() {
    super.initState();
    _loadSpecialties();
  }

  Future<void> _loadSpecialties() async {
    try {
      final specialties = await _specialtyService.getAllSpecialties();
      setState(() {
        _specialties = specialties;
        loadingSpecialties = false;
      });
    } catch (e) {
      setState(() => loadingSpecialties = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load specialties: $e")),
      );
    }
  }

  Future<void> _loadDoctors(String specialtySlug) async {
    setState(() {
      loadingDoctors = true;
      _doctors = [];
      selectedDoctor = null;
    });
    try {
      final doctors =
          await _doctorService.getDoctors(specialtySlug: specialtySlug);
      setState(() {
        _doctors = doctors;
        loadingDoctors = false;
      });
    } catch (e) {
      setState(() => loadingDoctors = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load doctors: $e")),
      );
    }
  }

  Future<void> _loadAvailability(String doctorId) async {
    setState(() {
      loadingSlots = true;
      _timeSlots = [];
      selectedTime = null;
    });
    try {
      final availability = await _doctorService.getDoctorAvailability(doctorId);
      // Assume backend returns [{"time": "09:00 AM"}, {"time": "10:00 AM"}]
      setState(() {
        _timeSlots = availability.map((a) => a["time"] as String).toList();
        loadingSlots = false;
      });
    } catch (e) {
      setState(() => loadingSlots = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load availability: $e")),
      );
    }
  }

  Future<void> _bookAppointment() async {
    if (selectedSpecialty == null ||
        selectedDoctor == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final appointment = Appointment(
      id: "", // backend generates
      doctorId: selectedDoctor!.id,
      patientId: "current_patient_id", // replace with auth user ID
      specialty: selectedSpecialty!,
      date: selectedDate.toIso8601String(),
      time: selectedTime!,
      note: noteController.text,
    );

    try {
      await _appointmentService.createAppointment(appointment);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment booked successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor = isDarkMode ? darkPrimaryColor : lightPrimaryColor;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color dropdownTextColor = isDarkMode ? Colors.white : primaryColor;
    final Color inputFillColor =
        isDarkMode ? Colors.grey.shade900 : primaryColor.withOpacity(0.05);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          AppLocalizations.of(context)!.bookAppointment,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Specialties
            loadingSpecialties
                ? const CircularProgressIndicator()
                : _buildDropdown(
                    label: AppLocalizations.of(context)!.selectSpeciality,
                    items: _specialties.map((s) => s['name'] as String).toList(),
                    value: selectedSpecialty,
                    onChanged: (val) {
                      setState(() => selectedSpecialty = val);
                      final slug = _specialties
                          .firstWhere((s) => s['name'] == val)['slug'] as String;
                      _loadDoctors(slug);
                    },
                    textColor: dropdownTextColor,
                    fillColor: inputFillColor,
                  ),

            const SizedBox(height: 16),

            // 🔹 Doctors
            loadingDoctors
                ? const CircularProgressIndicator()
                : _doctors.isEmpty
                    ? const Text("No doctors available")
                    : _buildDropdown(
                        label: AppLocalizations.of(context)!.selectDoctor,
                        items: _doctors.map((d) => d.name).toList(),
                        value: selectedDoctor?.name,
                        onChanged: (val) {
                          final doctor =
                              _doctors.firstWhere((d) => d.name == val);
                          setState(() => selectedDoctor = doctor);
                          _loadAvailability(doctor.id);
                        },
                        textColor: dropdownTextColor,
                        fillColor: inputFillColor,
                      ),

            const SizedBox(height: 20),

            // 🔹 Calendar
            _buildCalendar(primaryColor, dropdownTextColor),

            const SizedBox(height: 16),

            // 🔹 Time slots
            loadingSlots
                ? const CircularProgressIndicator()
                : _buildTimePicker(primaryColor, dropdownTextColor),

            const SizedBox(height: 16),

            _buildNoteInput(primaryColor, dropdownTextColor, inputFillColor),

            const SizedBox(height: 24),

            FadeInUp(
              delay: const Duration(milliseconds: 750),
              child: _buildBookButton(primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ DROPDOWN
  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
    required Color textColor,
    required Color fillColor,
  }) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: TextStyle(color: textColor)),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  // ✅ CALENDAR
  Widget _buildCalendar(Color primaryColor, Color textColor) {
    return TableCalendar(
      focusedDay: selectedDate,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      selectedDayPredicate: (day) =>
          day.year == selectedDate.year &&
          day.month == selectedDate.month &&
          day.day == selectedDate.day,
      onDaySelected: (selected, _) {
        setState(() => selectedDate = selected);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: primaryColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // ✅ TIME PICKER
  Widget _buildTimePicker(Color primaryColor, Color textColor) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _timeSlots
          .map((slot) => ChoiceChip(
                label: Text(slot,
                    style: TextStyle(
                        color: selectedTime == slot
                            ? Colors.white
                            : primaryColor)),
                selected: selectedTime == slot,
                onSelected: (selected) {
                  setState(() => selectedTime = slot);
                },
                selectedColor: primaryColor,
                backgroundColor: primaryColor.withOpacity(0.1),
              ))
          .toList(),
    );
  }

  // ✅ NOTE INPUT
  Widget _buildNoteInput(
      Color primaryColor, Color textColor, Color fillColor) {
    return TextField(
      controller: noteController,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "Add a note (optional)",
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ✅ BOOK BUTTON (already exists)
  Widget _buildBookButton(Color primaryColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.calendar_today_rounded, color: Colors.white),
        label: Text(AppLocalizations.of(context)!.bookAppointment,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: _bookAppointment,
      ),
    );
  }
}
