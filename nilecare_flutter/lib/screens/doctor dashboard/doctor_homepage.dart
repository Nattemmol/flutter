
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math';
import '../../l10n/app_localizations.dart';
import '../../services/doctor_service.dart';
import '../../services/appointment_service.dart';
import '../../services/stats_service.dart';
import '../../models/doctor.dart';
import '../../models/appointment.dart';

class DoctorHomePage extends StatefulWidget {
  final String doctorId;

  const DoctorHomePage({super.key, required this.doctorId});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>
    with SingleTickerProviderStateMixin {
  // Flip card controller
  late AnimationController _controller;
  bool _showFrontSide = true;

  // Services
  final DoctorService _doctorService = DoctorService();
  final AppointmentService _appointmentService = AppointmentService();
  final StatsService _statsService = StatsService();

  // Data
  List<Appointment> _todayAppointments = [];
  List<Map<String, dynamic>> _availability = [];
  bool _loadingAppointments = true;
  bool _loadingAvailability = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        _loadingAppointments = true;
        _loadingAvailability = true;
        _error = null;
      });

      final appointments =
          await _appointmentService.getDoctorAppointments(widget.doctorId);
      final availability =
          await _doctorService.getDoctorAvailability(widget.doctorId);

      setState(() {
        _todayAppointments = appointments;
        _availability = availability;
        _loadingAppointments = false;
        _loadingAvailability = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loadingAppointments = false;
        _loadingAvailability = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showFrontSide = !_showFrontSide;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final carouselBg = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = theme.textTheme.bodyLarge?.color;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.05,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/animations/doctor.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  _header(context),

                  const SizedBox(height: 20),

                  /// Today’s Schedule
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.todaysSchedule),
                  _loadingAppointments
                      ? const CircularProgressIndicator()
                      : _todayScheduleCard(context, cardColor, textColor),

                  const SizedBox(height: 24),

                  /// Announcements (placeholder)
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.announcements),
                  _carouselSection(carouselBg!),
                  const SizedBox(height: 24),

                  /// Recent Patients (using today's appointments)
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.recentPatients),
                  _loadingAppointments
                      ? const CircularProgressIndicator()
                      : _recentPatientsList(context),

                  const SizedBox(height: 24),

                  /// Availability
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.availability),
                  _loadingAvailability
                      ? const CircularProgressIndicator()
                      : _availabilityCard(cardColor, textColor),

                  const SizedBox(height: 24),

                  /// Pro Tip Flip Card
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.proTipForDoctors),
                  _flipCardWidget(cardColor, textColor),

                  const SizedBox(height: 30),

                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
  }


  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF003366), Color(0xFF336699)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppLocalizations.of(context)!.greeting}, Dr. Nathaniel 👨‍⚕️',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.doctorDashboardWelcome,
            style: GoogleFonts.lora(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    final color = Theme.of(context).textTheme.titleLarge?.color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _todayScheduleCard(
      BuildContext context, Color? cardColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Card(
          color: cardColor,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._todayAppointments.map((appointment) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${_formatTime(appointment.dateTime)} - ${appointment.patient?.name ?? "Unknown"} (${appointment.reason ?? "No reason provided"})',
                      style: GoogleFonts.poppins(color: textColor),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.schedule, color: Colors.white),
                    label: Text(
                      AppLocalizations.of(context)!.viewFullSchedule,
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF336699),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Widget _carouselSection(Color carouselBg) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: carouselBg,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/image$i.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _recentPatientsList(BuildContext context) {
    final patients = _todayAppointments
        .map((a) => {
              'name': a.patient?.name ?? 'Unknown',
              'reason': a.reasonForVisit ?? 'N/A'
            })
        .toList();

    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildPatientCard(
                patient['name']!, patient['reason']!, Colors.blue),
          );
        },
      ),
    );
  }

  Widget _availabilityCard(Color? cardColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _availability.isEmpty
              ? Text(
                  AppLocalizations.of(context)!.availabilityReminder,
                  style: GoogleFonts.poppins(color: textColor),
                )
              : Column(
                  children: _availability.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item['day']}: ${item['from']} - ${item['to']}",
                            style: GoogleFonts.poppins(color: textColor),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF336699),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.update,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }

  Widget _flipCardWidget(Color? cardColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final isUnder = (_controller.value > 0.5);
            var rotationValue = _controller.value;
            if (isUnder) rotationValue = 1 - rotationValue;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi * rotationValue),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                height: 120,
                child: isUnder
                    ? _buildTipBack(textColor)
                    : _buildTipFront(textColor),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTipFront(Color? textColor) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.proTipTitle,
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildTipBack(Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Text(
        AppLocalizations.of(context)!.proTipContent,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPatientCard(String name, String condition, Color color) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
          const SizedBox(height: 4),
          Text(condition,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
          const SizedBox(height: 6),
          Icon(Icons.folder_shared, color: color, size: 24),
        ],
      ),
    );
  }
}
