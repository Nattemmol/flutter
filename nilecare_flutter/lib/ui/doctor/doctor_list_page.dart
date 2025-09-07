import 'package:flutter/material.dart';
import '../../services/doctor_service.dart';
import '../../services/specialties_service.dart';
import '../../services/services_service.dart';
import '../../models/doctor.dart';
import 'doctor_details_page.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({Key? key}) : super(key: key);

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  bool _isLoading = false;
  List<Doctor> _doctors = [];
  String? _selectedSpecialty;
  String? _selectedService;
  final _searchController = TextEditingController();
  late final DoctorService _doctorService;
  late final SpecialtiesService _specialtiesService;
  late final ServicesService _servicesService;

  @override
  void initState() {
    super.initState();
    _doctorService = DoctorService();
    _specialtiesService = SpecialtiesService();
    _servicesService = ServicesService();
    _loadDoctors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDoctors() async {
    setState(() => _isLoading = true);
    try {
      final doctors = await _doctorService.getDoctors(
        specialtySlug: _selectedSpecialty,
        serviceSlug: _selectedService,
        searchQuery:
            _searchController.text.isEmpty ? null : _searchController.text,
      );
      setState(() {
        _doctors = doctors;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Doctor'),
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _doctors.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.medical_services,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No doctors found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = _doctors[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                  doctor.profileImage ??
                                      'https://placeholder.com/150',
                                ),
                              ),
                              title: Text(
                                'Dr. ${doctor.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(doctor.specialization),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDetailsPage(
                                      doctorId: doctor.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search doctors...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) => _loadDoctors(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSpecialtyDropdown(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildServiceDropdown(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyDropdown() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _specialtiesService.getSpecialties()
          as Future<List<Map<String, dynamic>>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final specialties = snapshot.data ?? [];
        return DropdownButtonFormField<String>(
          value: _selectedSpecialty,
          decoration: InputDecoration(
            labelText: 'Specialty',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Specialties'),
            ),
            ...specialties.map((specialty) {
              return DropdownMenuItem(
                value: specialty['slug'],
                child: Text(specialty['name']),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              _selectedSpecialty = value;
              _loadDoctors();
            });
          },
        );
      },
    );
  }

  Widget _buildServiceDropdown() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          _servicesService.getServices() as Future<List<Map<String, dynamic>>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final services = snapshot.data ?? [];
        return DropdownButtonFormField<String>(
          value: _selectedService,
          decoration: InputDecoration(
            labelText: 'Service',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Services'),
            ),
            ...services.map((service) {
              return DropdownMenuItem(
                value: service['slug'],
                child: Text(service['name']),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              _selectedService = value;
              _loadDoctors();
            });
          },
        );
      },
    );
  }
}
