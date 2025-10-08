import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class ServicesService {
  final ApiClient _apiClient = ApiClient();

  // Create a new service
  Future<Map<String, dynamic>> createService(
      Map<String, dynamic> serviceData) async {
    try {
      final response = await _apiClient.post(
        '/api/services',
        data: serviceData,
      );
      return response['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all services or a specific service by slug
  Future<dynamic> getServices({String? slug}) async {
    try {
      final queryParams = <String, String>{};
      if (slug != null) queryParams['slug'] = slug;

      final response = await _apiClient.get(
        '/api/services',
        queryParameters: queryParams,
      );
      return response['data'];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update a service
  Future<Map<String, dynamic>> updateService({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _apiClient.put(
        '/api/services',
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

  // Delete a service
  Future<bool> deleteService(String id) async {
    try {
      await _apiClient.delete('/api/services?id=$id');
      return true;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all services
  Future<List<Map<String, dynamic>>> getAllServices() async {
    try {
      final response = await _apiClient.get('/api/services');
      final List<dynamic> data = response['data'];
      return data.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw _handleServicesError(e);
    }
  }

  // Get service by slug
  Future<Map<String, dynamic>> getServiceBySlug(String slug) async {
    try {
      final response = await _apiClient.get('/api/services/$slug');
      return response['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleServicesError(e);
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
    return Exception('Services service error: ${e.message}');
  }

  // Error handling for services operations
  Exception _handleServicesError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Services operation failed: ${e.message}');
  }
}
