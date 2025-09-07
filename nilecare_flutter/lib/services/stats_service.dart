import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class StatsService {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.headers;
  static const String _tokenKey = 'auth_token';
  final ApiClient _apiClient = ApiClient();

  // Get statistics based on type
  Future<dynamic> getStats({String type = 'basic'}) async {
    try {
      final queryParams = <String, String>{
        'type': type,
      };

      final uri =
          Uri.parse('$baseUrl/api/stats').replace(queryParameters: queryParams);
      final response = await http.get(
        uri,
        headers: {
          ...headers,
          'Authorization': 'Bearer ${await _getToken()}',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message'] ??
            'Failed to fetch statistics');
      }
    } catch (e) {
      throw Exception('Error fetching statistics: $e');
    }
  }

  // Get basic statistics
  Future<Map<String, dynamic>> getBasicStats() async {
    return getStats(type: 'basic') as Future<Map<String, dynamic>>;
  }

  // Get admin analytics
  Future<List<dynamic>> getAdminAnalytics() async {
    return getStats(type: 'admin') as Future<List<dynamic>>;
  }

  // Get doctor analytics
  Future<List<dynamic>> getDoctorAnalytics() async {
    return getStats(type: 'doctor') as Future<List<dynamic>>;
  }

  // Get user analytics
  Future<List<Map<String, dynamic>>> getUserAnalytics() async {
    try {
      final response = await _apiClient.get('/api/stats/user-analytics');
      if (response is Map<String, dynamic> && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((item) => Map<String, dynamic>.from(item)).toList();
      } else if (response is List) {
        return response.map((item) => Map<String, dynamic>.from(item)).toList();
      }
      throw Exception('Invalid response format');
    } on DioException catch (e) {
      throw _handleStatsError(e);
    }
  }

  // Get token from shared preferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? '';
  }

  // Get detailed doctor analytics
  Future<List<Map<String, dynamic>>> getDoctorDetailedAnalytics(
      String doctorId) async {
    try {
      final response =
          await _apiClient.get('/api/stats/doctor-analytics/$doctorId');
      final List<dynamic> data = response['data'];
      return data.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw _handleStatsError(e);
    }
  }

  // Get hospital analytics
  Future<List<Map<String, dynamic>>> getHospitalAnalytics() async {
    try {
      final response = await _apiClient.get('/api/stats/hospital-analytics');
      final List<dynamic> data = response['data'];
      return data.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw _handleStatsError(e);
    }
  }

  // Error handling
  Exception _handleStatsError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Stats operation failed: ${e.message}');
  }
}
