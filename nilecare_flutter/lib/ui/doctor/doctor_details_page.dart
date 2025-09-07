import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/doctor_service.dart';
import '../../services/appointment_service.dart';
import '../../services/auth_service.dart';
import '../../models/doctor.dart';
import '../../models/appointment.dart';

class DoctorDetailsPage extends StatefulWidget {
  final String doctorId;

  const DoctorDetailsPage({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  bool _isLoading = false;
  Doctor? _doctor;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadDoctorDetails();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final currentUser = await authService.getCurrentUser();
      setState(() {
        _userId = currentUser.id;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loadDoctorDetails() async {
    setState(() => _isLoading = true);
    try {
      final doctorService = Provider.of<DoctorService>(context, listen: false);
      final doctor = await doctorService.getDoctorById(widget.doctorId);
      setState(() {
        _doctor = doctor;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _doctor == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorInfo(),
                  const SizedBox(height: 24),
                  _buildAboutSection(),
                  const SizedBox(height: 24),
                  _buildSpecializationSection(),
                  const SizedBox(height: 24),
                  _buildExperienceSection(),
                  const SizedBox(height: 24),
                  _buildReviewsSection(),
                  const SizedBox(height: 24),
                  _buildAppointmentSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          _doctor!.profileImage ?? 'https://placeholder.com/400x200',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            _doctor!.profileImage ?? 'https://placeholder.com/150',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr. ${_doctor!.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _doctor!.specialization,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    _doctor!.rating?.toString() ?? '4.5',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${_doctor!.reviewCount ?? 0} reviews)',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _doctor!.bio ?? 'No description available',
          style: TextStyle(
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecializationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specializations',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final lang in _doctor!.languages ?? [])
              Chip(
                label: Text(lang),
                backgroundColor: Colors.blue.withAlpha(25),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experience',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_doctor!.experience ?? 0} years of experience',
          style: TextStyle(
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (_doctor!.reviews?.isEmpty ?? true)
          Text(
            'No reviews yet',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _doctor!.reviews!.length,
            itemBuilder: (context, index) {
              final review = _doctor!.reviews![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            child: Text(
                              review.userName.isNotEmpty
                                  ? review.userName[0]
                                  : '?',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    review.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(review.comment),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildAppointmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildDateSelector(),
        const SizedBox(height: 16),
        _buildTimeSlots(),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = _selectedDate?.year == date.year &&
                  _selectedDate?.month == date.month &&
                  _selectedDate?.day == date.day;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedDate = date);
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey[300]!,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        _getMonthName(date.month),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlots() {
    final timeSlots = [
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: timeSlots.map((time) {
            final isSelected = _selectedTimeSlot == time;
            return ChoiceChip(
              label: Text(time),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedTimeSlot = selected ? time : null);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Consultation Fee',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$${_doctor!.consultationFee}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _selectedDate != null && _selectedTimeSlot != null
                ? _handleBookAppointment
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            child: const Text('Book Appointment'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleBookAppointment() async {
    if (_selectedDate == null || _selectedTimeSlot == null || _userId == null) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      final appointmentService =
          Provider.of<AppointmentService>(context, listen: false);
      await appointmentService.createAppointment(
        Appointment(
          id: '', // This will be set by the server
          doctorId: widget.doctorId,
          patientId: _userId!,
          serviceId: _doctor!.serviceId,
          dateTime: DateTime.parse(
              '${_selectedDate!.toIso8601String().split('T')[0]}T${_selectedTimeSlot!}'),
          status: 'pending',
          type: 'in-person',
          amount: _doctor!.consultationFee,
          currency: 'USD',
          isPaid: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment booked successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
