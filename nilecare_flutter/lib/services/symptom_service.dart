import 'dart:convert';
import 'package:http/http.dart' as http;

class SymptomService {
  final String baseUrl;
  final String apiKey;

  SymptomService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Create a new symptom
  Future<Map<String, dynamic>> createSymptom(Map<String, dynamic> symptomData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/symptom'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(symptomData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create symptom: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating symptom: $e');
    }
  }

  // Get all symptoms or a specific symptom by slug
  Future<dynamic> getSymptoms({String? slug}) async {
    try {
      final queryParams = <String, String>{};
      
      if (slug != null) queryParams['slug'] = slug;

      final uri = Uri.parse('$baseUrl/api/symptom').replace(queryParameters: queryParams);
      
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to fetch symptoms: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching symptoms: $e');
    }
  }

  // Update a symptom
  Future<Map<String, dynamic>> updateSymptom({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/symptom'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'id': id,
          'data': data,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update symptom: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating symptom: $e');
    }
  }

  // Delete a symptom
  Future<bool> deleteSymptom(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/symptom?id=$id'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete symptom: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting symptom: $e');
    }
  }
} 