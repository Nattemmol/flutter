import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../models/user.dart';

class UserService {
  final String baseUrl;
  final String apiKey;
  final ApiClient _apiClient = ApiClient();

  UserService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Get user profile
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await _apiClient.get('/api/users/$userId');
      return response['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleUserError(e);
    }
  }

  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await _apiClient.put(
        '/api/users/$userId',
        data: userData,
      );
      return response['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleUserError(e);
    }
  }

  // Upload profile image
  Future<String> uploadProfileImage(String userId, String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await _apiClient.post(
        '/api/users/$userId/profile-image',
        data: formData,
      );

      return response['data']['imageUrl'] as String;
    } on DioException catch (e) {
      throw _handleUserError(e);
    }
  }

  // Delete user account
  Future<void> deleteUserAccount(String userId) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/users/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete user account: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting user account: $e');
    }
  }

  // Change password
  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/users/$userId/change-password'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change password: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error changing password: $e');
    }
  }

  // Helper method for token management
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Error handling
  Exception _handleUserError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('User operation failed: ${e.message}');
  }
}
