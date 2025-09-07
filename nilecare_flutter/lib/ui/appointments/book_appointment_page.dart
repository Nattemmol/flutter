import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/appointment_service.dart';
import '../../services/auth_service.dart';
import '../../services/doctor_service.dart' as doctor_service;
import '../../models/appointment.dart';
import '../../models/doctor.dart';
import 'package:intl/intl.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({Key? key}) : super(key: key);

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  List<Doctor> _doctors = [];
  Doctor? _selectedDoctor;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _appointmentType = 'inPerson';
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadDoctors() async {
    try {
      final doctors = await doctor_service.DoctorService().getDoctors();
      setState(() {
        _doctors = doctors
            .map((d) => Doctor(
                  id: d.id,
                  name: d.name,
                  email: d.email,
                  phoneNumber: d.phoneNumber,
                  specialization: d.specialization,
                  serviceId: d.serviceId,
                  profileImage: d.profileImage,
                  bio: d.bio,
                  languages: d.languages,
                  certifications: d.certifications,
                  consultationFee: d.consultationFee,
                  createdAt: d.createdAt,
                  updatedAt: d.updatedAt,
                ))
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading doctors: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }

  Future<void> _bookAppointment() async {
    if (_selectedDoctor == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      final appointment = Appointment(
        id: '', // Will be set by the backend
        doctorId: _selectedDoctor!.id,
        patientId: 'current-user-id', // Replace with actual user ID
        serviceId: _selectedDoctor!.serviceId,
        dateTime: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ),
        type: 'consultation',
        status: 'pending',
        amount: _selectedDoctor!.consultationFee,
        currency: 'USD',
        isPaid: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await AppointmentService().createAppointment(appointment);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error booking appointment: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadDoctors,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<Doctor>(
                          value: _selectedDoctor,
                          decoration: const InputDecoration(
                            labelText: 'Select Doctor',
                            border: OutlineInputBorder(),
                          ),
                          items: _doctors.map((doctor) {
                            return DropdownMenuItem(
                              value: doctor,
                              child: Text(
                                  'Dr. ${doctor.name} - ${doctor.specialization}'),
                            );
                          }).toList(),
                          onChanged: (Doctor? value) {
                            setState(() => _selectedDoctor = value);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a doctor';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text('Date'),
                          subtitle: Text(
                            DateFormat('MMM dd, yyyy').format(_selectedDate),
                          ),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: () => _selectDate(context),
                        ),
                        ListTile(
                          title: const Text('Time'),
                          subtitle: Text(_selectedTime.format(context)),
                          trailing: const Icon(Icons.access_time),
                          onTap: () => _selectTime(context),
                        ),
                        const SizedBox(height: 16),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'inPerson',
                              label: Text('In Person'),
                              icon: Icon(Icons.person),
                            ),
                            ButtonSegment(
                              value: 'online',
                              label: Text('Online'),
                              icon: Icon(Icons.video_camera_front),
                            ),
                          ],
                          selected: {_appointmentType},
                          onSelectionChanged: (Set<String> newSelection) {
                            setState(
                                () => _appointmentType = newSelection.first);
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            labelText: 'Notes (Optional)',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _bookAppointment,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Book Appointment'),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
