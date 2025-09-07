import 'package:flutter/material.dart';
import '../../services/stats_service.dart';
import '../../services/auth_service.dart';
import '../../services/appointment_service.dart';
import '../../services/doctor_service.dart';
import '../../models/appointment.dart';
import '../../models/doctor.dart';
import '../appointments/appointments_page.dart';
import '../doctor/doctor_list_page.dart';
import '../doctor/doctor_details_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  Map<String, dynamic>? _stats;
  List<dynamic> _upcomingAppointments = [];
  List<dynamic> _featuredDoctors = [];
  String? _userId;
  int _currentIndex = 0;

  final _authService = AuthService();
  final _statsService = StatsService();
  final _appointmentService = AppointmentService();
  final _doctorService = DoctorService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      print('Starting to load data...');
      final currentUser = await _authService.getCurrentUser();
      print('Current user: ${currentUser?.id}');
      _userId = currentUser?.id;

      if (_userId == null) {
        throw Exception('User ID not found');
      }

      print('Loading data in parallel...');
      // Load all data in parallel
      final results = await Future.wait([
        _statsService.getUserAnalytics(),
        _appointmentService.getUpcomingAppointments(),
        _doctorService.getFeaturedDoctors(),
      ]);

      print('Data loaded successfully:');
      print('Stats data: ${results[0]}');
      print('Appointments data: ${results[1]}');
      print('Doctors data: ${results[2]}');

      // Handle potential null or empty responses
      final statsData = results[0] as List<Map<String, dynamic>>;
      final appointmentsData = results[1] as List<Appointment>;
      final doctorsData = results[2] as List<Doctor>;

      setState(() {
        _stats = {
          'totalAppointments':
              statsData.isNotEmpty ? (statsData[0]['appointments'] ?? 0) : 0,
          'totalPrescriptions':
              statsData.isNotEmpty ? (statsData[0]['prescriptions'] ?? 0) : 0,
          'totalReports':
              statsData.isNotEmpty ? (statsData[0]['reports'] ?? 0) : 0,
        };
        _upcomingAppointments = appointmentsData;
        _featuredDoctors = doctorsData;
      });
    } catch (e, stackTrace) {
      print('Error loading data: $e');
      print('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: ${e.toString()}'),
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

  void _onNavigationTap(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AppointmentsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DoctorListPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NileCare'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 24),
                    _buildQuickActions(),
                    const SizedBox(height: 24),
                    _buildStatsSection(),
                    const SizedBox(height: 24),
                    _buildUpcomingAppointments(),
                    const SizedBox(height: 24),
                    _buildFeaturedDoctors(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: _onNavigationTap,
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Here\'s what\'s happening with your health today.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    if (_stats == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Health Stats',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildStatCard(
              'Appointments',
              _stats!['totalAppointments'].toString(),
              Icons.calendar_today,
              Colors.blue,
            ),
            _buildStatCard(
              'Prescriptions',
              _stats!['totalPrescriptions'].toString(),
              Icons.medication,
              Colors.green,
            ),
            _buildStatCard(
              'Reports',
              _stats!['totalReports'].toString(),
              Icons.description,
              Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildActionItem(Icons.calendar_today, 'Book\nAppointment'),
            _buildActionItem(Icons.medical_services, 'Find\nDoctor'),
            _buildActionItem(Icons.local_pharmacy, 'Pharmacy'),
            _buildActionItem(Icons.emergency, 'Emergency'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blue, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildUpcomingAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming Appointments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppointmentsPage()),
                );
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: _upcomingAppointments.isEmpty
              ? const Center(child: Text('No upcoming appointments'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _upcomingAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = _upcomingAppointments[index];
                    return Card(
                      margin: const EdgeInsets.only(right: 16),
                      child: Container(
                        width: 280,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    appointment['doctor']['profileImage'] ??
                                        'https://placeholder.com/150',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment['doctor']['name'] ??
                                          'Unknown Doctor',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      appointment['doctor']['specialty'] ??
                                          'Unknown Specialty',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 8),
                                Text(appointment['date'] ?? 'No date'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16),
                                const SizedBox(width: 8),
                                Text(appointment['location'] ?? 'No location'),
                              ],
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

  Widget _buildFeaturedDoctors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured Doctors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DoctorListPage()),
                );
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _featuredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = _featuredDoctors[index];
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            doctor['profileImage'] ??
                                'https://placeholder.com/150',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor['name'] ?? 'Unknown Doctor',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          doctor['specialty'] ?? 'Unknown Specialty',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              (doctor['rating'] ?? 0).toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // Navigate to doctor details
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDetailsPage(
                                      doctorId: doctor['id'],
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Book',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
