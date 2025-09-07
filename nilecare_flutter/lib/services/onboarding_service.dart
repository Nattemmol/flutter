import 'dart:convert';
import 'package:http/http.dart' as http;

class OnboardingService {
  final String baseUrl;
  final String apiKey;

  OnboardingService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Create a new doctor profile
  Future<Map<String, dynamic>> createDoctorProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/onboarding'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(profileData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create doctor profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating doctor profile: $e');
    }
  }

  // Get doctor profile by tracking number or userId
  Future<Map<String, dynamic>> getDoctorProfile({
    String? trackingNumber,
    String? userId,
  }) async {
    try {
      final queryParams = <String, String>{};
      
      if (trackingNumber != null) queryParams['trackingNumber'] = trackingNumber;
      if (userId != null) queryParams['userId'] = userId;

      final uri = Uri.parse('$baseUrl/api/onboarding').replace(queryParameters: queryParams);
      
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch doctor profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching doctor profile: $e');
    }
  }

  // Update doctor profile
  Future<Map<String, dynamic>> updateDoctorProfile({
    required String id,
    required Map<String, dynamic> data,
    bool complete = false,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/onboarding'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'id': id,
          'data': data,
          'complete': complete,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update doctor profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating doctor profile: $e');
    }
  }
} 