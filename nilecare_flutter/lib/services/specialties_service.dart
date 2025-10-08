import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class SpecialtiesService {
  final ApiClient _apiClient = ApiClient();

  // Create a new specialty
  Future<Map<String, dynamic>> createSpecialty(
      Map<String, dynamic> specialtyData) async {
    try {
      final response = await _apiClient.post(
        '/api/specialities',
        data: specialtyData,
      );
      return response['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all specialties or a specific specialty by slug
  Future<dynamic> getSpecialties({String? slug}) async {
    try {
      final queryParams = <String, String>{};
      if (slug != null) queryParams['slug'] = slug;

      final response = await _apiClient.get(
        '/api/specialities',
        queryParameters: queryParams,
      );
      return response['data'];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update a specialty
  Future<Map<String, dynamic>> updateSpecialty({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _apiClient.put(
        '/api/specialities',
        data: {
          'id': id,
          'data': data,
        },
      );
      return response['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete a specialty
  Future<bool> deleteSpecialty(String id) async {
    try {
      await _apiClient.delete('/api/specialities?id=$id');
      return true;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all specialties
  Future<List<Map<String, dynamic>>> getAllSpecialties() async {
    try {
      final response = await _apiClient.get('/api/specialties');
      final List<dynamic> data = response['data'];
      return data.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw _handleSpecialtiesError(e);
    }
  }

  // Get specialty by slug
  Future<Map<String, dynamic>> getSpecialtyBySlug(String slug) async {
    try {
      final response = await _apiClient.get('/api/specialties/$slug');
      return response['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleSpecialtiesError(e);
    }
  }

  // Error handling
  Exception _handleError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Specialties service error: ${e.message}');
  }

  // Error handling
  Exception _handleSpecialtiesError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Specialties operation failed: ${e.message}');
  }
}
