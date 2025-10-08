import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../models/appointment.dart';

class AppointmentService {
  final ApiClient _apiClient = ApiClient();

  // Create a new appointment
  Future<Appointment> createAppointment(Appointment appointment) async {
    try {
      final response = await _apiClient.post(
        '/api/appointments',
        data: appointment.toJson(),
      );
      return Appointment.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Update an appointment
  Future<Appointment> updateAppointment(
      String id, Appointment appointment) async {
    try {
      final response = await _apiClient.put(
        '/api/appointments/$id',
        data: appointment.toJson(),
      );
      return Appointment.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Get all appointments
  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await _apiClient.get('/api/appointments');
      final List<dynamic> appointmentsJson = response['data'];
      return appointmentsJson
          .map((json) => Appointment.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Get patient appointments
  Future<List<Appointment>> getPatientAppointments(String patientId) async {
    try {
      final response = await _apiClient.get(
        '/api/appointments',
        queryParameters: {'patientId': patientId},
      );
      final List<dynamic> appointmentsJson = response['data'];
      return appointmentsJson
          .map((json) => Appointment.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Get doctor appointments
  Future<List<Appointment>> getDoctorAppointments(String doctorId) async {
    try {
      final response =
          await _apiClient.get('/api/appointments/doctor/$doctorId');
      final List<dynamic> appointmentsJson = response['data'];
      return appointmentsJson
          .map((json) => Appointment.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Get appointment by ID
  Future<Appointment> getAppointmentById(String id) async {
    try {
      final response = await _apiClient.get('/api/appointments/$id');
      return Appointment.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Cancel an appointment
  Future<void> cancelAppointment(String id) async {
    try {
      await _apiClient.put(
        '/api/appointments/$id/cancel',
      );
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Delete appointment
  Future<void> deleteAppointment(String id) async {
    try {
      await _apiClient.delete('/api/appointments/$id');
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Get upcoming appointments
  Future<List<Appointment>> getUpcomingAppointments() async {
    try {
      final response = await _apiClient.get(
        '/api/appointments',
        queryParameters: {'status': 'upcoming'},
      );
      final List<dynamic> appointmentsJson = response['data'];
      return appointmentsJson
          .map((json) => Appointment.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleAppointmentError(e);
    }
  }

  // Error handling
  Exception _handleAppointmentError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Appointment operation failed: ${e.message}');
  }
}
