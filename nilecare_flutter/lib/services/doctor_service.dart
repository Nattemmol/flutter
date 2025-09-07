import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../models/doctor.dart';

class DoctorService {
  final ApiClient _apiClient = ApiClient();

  // Get all doctors with optional filters
  Future<List<Doctor>> getDoctors({
    String? serviceSlug,
    String? specialtySlug,
    String? symptomId,
    String? searchQuery,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (serviceSlug != null) queryParams['service'] = serviceSlug;
      if (specialtySlug != null) queryParams['specialty'] = specialtySlug;
      if (symptomId != null) queryParams['symptom'] = symptomId;
      if (searchQuery != null) queryParams['search'] = searchQuery;

      final response = await _apiClient.get(
        '/api/doctors',
        queryParameters: queryParams,
      );

      final List<dynamic> doctorsJson = response['data'];
      return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Get doctor by ID
  Future<Doctor> getDoctorById(String id) async {
    try {
      final response = await _apiClient.get('/api/doctors/$id');
      return Doctor.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Get doctor reviews
  Future<List<Review>> getDoctorReviews(String doctorId) async {
    try {
      final response = await _apiClient.get('/api/doctors/$doctorId/reviews');
      final List<dynamic> reviewsJson = response['data'];
      return reviewsJson.map((json) => Review.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Add a review for a doctor
  Future<Review> addDoctorReview(String doctorId, Review review) async {
    try {
      final response = await _apiClient.post(
        '/api/doctors/$doctorId/reviews',
        data: review.toJson(),
      );
      return Review.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Update doctor
  Future<Doctor> updateDoctor(String id, Doctor doctor) async {
    try {
      final response = await _apiClient.put(
        '/api/doctors/$id',
        data: doctor.toJson(),
      );
      return Doctor.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Delete doctor
  Future<void> deleteDoctor(String id) async {
    try {
      await _apiClient.delete('/api/doctors/$id');
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Get doctor availability
  Future<List<Map<String, dynamic>>> getDoctorAvailability(
      String doctorId) async {
    try {
      final response =
          await _apiClient.get('/api/doctors/$doctorId/availability');
      final List<dynamic> data = response['data'];
      return data.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Get featured doctors
  Future<List<Doctor>> getFeaturedDoctors() async {
    try {
      final response = await _apiClient.get(
        '/api/doctors',
        queryParameters: {'featured': 'true'},
      );
      final List<dynamic> doctorsJson = response['data'];
      return doctorsJson.map((json) => Doctor.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDoctorError(e);
    }
  }

  // Error handling
  Exception _handleDoctorError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Doctor operation failed: ${e.message}');
  }
}
