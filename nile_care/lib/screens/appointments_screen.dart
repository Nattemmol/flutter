import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final Color lightPrimaryColor =
      const Color(0xFF1F2A44); // Blue-black tone for light mode
  final Color darkPrimaryColor =
      const Color(0xFF2A3A66); // Purple tone for dark mode

  final List<String> _specialties = [
    'Dentist',
    'Cardiologist',
    'Pediatrician',
    'Dermatologist',
  ];

  final List<String> _doctors = [
    'Dr. James',
    'Dr. Olivia',
    'Dr. Amanuel',
    'Dr. Grace',
  ];

  final List<String> _timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
  ];

  String? selectedSpecialty;
  String? selectedDoctor;
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color primaryColor =
        isDarkMode ? darkPrimaryColor : lightPrimaryColor;
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
            FadeIn(
                child: _buildDropdown(
                    context,
                    AppLocalizations.of(context)!.selectSpeciality,
                    _specialties,
                    selectedSpecialty,
                    (val) => setState(() => selectedSpecialty = val),
                    dropdownTextColor,
                    inputFillColor)),
            const SizedBox(height: 16),
            FadeIn(
                delay: const Duration(milliseconds: 150),
                child: _buildDropdown(
                    context,
                    AppLocalizations.of(context)!.selectDoctor,
                    _doctors,
                    selectedDoctor,
                    (val) => setState(() => selectedDoctor = val),
                    dropdownTextColor,
                    inputFillColor)),
            const SizedBox(height: 20),
            FadeIn(
                delay: const Duration(milliseconds: 300),
                child: _buildCalendar(primaryColor, dropdownTextColor)),
            const SizedBox(height: 16),
            FadeIn(
                delay: const Duration(milliseconds: 450),
                child: _buildTimePicker(primaryColor, dropdownTextColor)),
            const SizedBox(height: 16),
            FadeIn(
                delay: const Duration(milliseconds: 600),
                child: _buildNoteInput(
                    primaryColor, dropdownTextColor, inputFillColor)),
            const SizedBox(height: 24),
            FadeInUp(
                delay: const Duration(milliseconds: 750),
                child: _buildBookButton(primaryColor)),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: FadeIn(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  height: 2,
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(0),
                        dropdownTextColor,
                        primaryColor.withOpacity(0)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ),
            FadeInUp(
                delay: const Duration(milliseconds: 900),
                child: _buildStaticInfoSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
      BuildContext context,
      String hint,
      List<String> items,
      String? value,
      Function(String?) onChanged,
      Color textColor,
      Color fillColor) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      hint: Text(hint,
          style: GoogleFonts.poppins(color: textColor.withOpacity(0.7))),
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: GoogleFonts.poppins(color: textColor))))
          .toList(),
      onChanged: onChanged,
      iconStyleData: IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: textColor)),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: fillColor,
        ),
      ),
    );
  }

  Widget _buildCalendar(Color primaryColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: primaryColor.withOpacity(0.05),
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 60)),
        focusedDay: selectedDate,
        calendarFormat: CalendarFormat.week,
        selectedDayPredicate: (day) => isSameDay(day, selectedDate),
        onDaySelected: (day, focusedDay) =>
            setState(() => selectedDate = focusedDay),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: textColor),
          leftChevronIcon: Icon(Icons.chevron_left, color: textColor),
          rightChevronIcon: Icon(Icons.chevron_right, color: textColor),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration:
              BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(
              color: primaryColor.withOpacity(0.8), shape: BoxShape.circle),
          defaultTextStyle: GoogleFonts.poppins(color: textColor),
          weekendTextStyle:
              GoogleFonts.poppins(color: textColor.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget _buildTimePicker(Color primaryColor, Color textColor) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _timeSlots.map((slot) {
        final isSelected = slot == selectedTime;
        return ChoiceChip(
          label: Text(slot,
              style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : textColor,
                  fontWeight: FontWeight.w600)),
          selected: isSelected,
          onSelected: (_) => setState(() => selectedTime = slot),
          selectedColor: primaryColor,
          backgroundColor: primaryColor.withOpacity(0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        );
      }).toList(),
    );
  }

  Widget _buildNoteInput(Color primaryColor, Color textColor, Color fillColor) {
    return TextField(
      controller: noteController,
      maxLines: 3,
      style: GoogleFonts.poppins(color: textColor),
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.additionalNote,
        hintStyle: GoogleFonts.poppins(color: textColor.withOpacity(0.5)),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Appointment booked!"))),
      ),
    );
  }

  Widget _buildStaticInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Contact us tapped!'))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF1F2A44), Color(0xFF2A3A66)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              BounceInDown(
                  duration: const Duration(milliseconds: 1800),
                  child: const Icon(Icons.phone_in_talk_rounded,
                      size: 50, color: Colors.white)),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.needHelp,
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.needHelpDesc,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white70, height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content: Text('Contact us tapped!'))),
                      icon: const Icon(Icons.mail_outline_rounded,
                          color: Colors.white),
                      label: Text(AppLocalizations.of(context)!.contactUs,
                          style: const TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent.shade400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 6,
                        shadowColor: Colors.lightBlueAccent.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
