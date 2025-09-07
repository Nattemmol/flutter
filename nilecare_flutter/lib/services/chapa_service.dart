import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChapaService {
  final String baseUrl;
  final String apiKey;

  ChapaService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Initialize payment
  Future<Map<String, dynamic>> initializePayment({
    required String amount,
    required String currency,
    required String email,
    required String firstName,
    required String lastName,
    required String txRef,
    String? callbackUrl,
    String? returnUrl,
    Map<String, dynamic>? customizations,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/chapa'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'txRef': txRef,
          'callbackUrl': callbackUrl,
          'returnUrl': returnUrl,
          'customizations': customizations,
          'metadata': metadata,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to initialize payment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error initializing payment: $e');
    }
  }

  // Verify payment
  Future<Map<String, dynamic>> verifyPayment(String txRef) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/chapa/verify?txRef=$txRef'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to verify payment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error verifying payment: $e');
    }
  }

  // Get payment history
  Future<List<Map<String, dynamic>>> getPaymentHistory({
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

      final uri = Uri.parse('$baseUrl/api/chapa/history').replace(queryParameters: queryParams);

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
        throw Exception('Failed to get payment history: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting payment history: $e');
    }
  }

  // Helper method for token management
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
} 