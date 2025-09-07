import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../models/patient.dart';
import '../models/appointment.dart';

class PatientService {
  final ApiClient _apiClient = ApiClient();

  // Get patient profile
  Future<Patient> getPatientProfile(String id) async {
    try {
      final response = await _apiClient.get('/api/patients/$id');
      return Patient.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handlePatientError(e);
    }
  }

  // Update patient profile
  Future<Patient> updatePatientProfile(String id, Patient patient) async {
    try {
      final response = await _apiClient.put(
        '/api/patients/$id',
        data: patient.toJson(),
      );
      return Patient.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handlePatientError(e);
    }
  }

  // Update medical history
  Future<Patient> updateMedicalHistory(
    String id, {
    required List<String> medicalHistory,
    required List<String> allergies,
    required List<String> medications,
  }) async {
    try {
      final response = await _apiClient.put(
        '/api/patients/$id/medical-history',
        data: {
          'medicalHistory': medicalHistory,
          'allergies': allergies,
          'medications': medications,
        },
      );
      return Patient.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handlePatientError(e);
    }
  }

  // Upload profile image
  Future<String> uploadProfileImage(String id, String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await _apiClient.post(
        '/api/patients/$id/profile-image',
        data: formData,
      );
      return response['data']['imageUrl'];
    } on DioException catch (e) {
      throw _handlePatientError(e);
    }
  }

  // Get patient's appointments
  Future<List<Appointment>> getPatientAppointments(String id) async {
    try {
      final response = await _apiClient.get('/api/patients/$id/appointments');
      final List<dynamic> appointmentsJson = response['data'];
      return appointmentsJson
          .map((json) => Appointment.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handlePatientError(e);
    }
  }

  // Get patient's medical records
  Future<List<Map<String, dynamic>>> getMedicalRecords(String id) async {
    try {
      final response =
          await _apiClient.get('/api/patients/$id/medical-records');
      final List<dynamic> recordsJson = response['data'];
      return recordsJson.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw _handlePatientError(e);
    }
  }

  // Error handling
  Exception _handlePatientError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Patient operation failed: ${e.message}');
  }
}
