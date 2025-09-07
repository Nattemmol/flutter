import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerifyChapaService {
  final String baseUrl;
  final String apiKey;

  VerifyChapaService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Verify payment status
  Future<Map<String, dynamic>> verifyPaymentStatus(String txRef) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/verifychapa?txRef=$txRef'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to verify payment status: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error verifying payment status: $e');
    }
  }

  // Verify payment with webhook
  Future<Map<String, dynamic>> verifyPaymentWithWebhook({
    required String txRef,
    required String transactionId,
    required String status,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/verifychapa/webhook'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'txRef': txRef,
          'transactionId': transactionId,
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to verify payment with webhook: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error verifying payment with webhook: $e');
    }
  }

  // Get verification history
  Future<List<Map<String, dynamic>>> getVerificationHistory({
    String? userId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      // Build query parameters
      final queryParams = <String, String>{};
      if (userId != null) queryParams['userId'] = userId;
      if (status != null) queryParams['status'] = status;
      if (startDate != null) queryParams['startDate'] = startDate.toIso8601String();
      if (endDate != null) queryParams['endDate'] = endDate.toIso8601String();

      final uri = Uri.parse('$baseUrl/api/verifychapa/history').replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to get verification history: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting verification history: $e');
    }
  }

  // Helper method for token management
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
} 