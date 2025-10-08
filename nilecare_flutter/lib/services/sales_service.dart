import 'dart:convert';
import 'package:http/http.dart' as http;

class SalesService {
  final String baseUrl;
  final String apiKey;

  SalesService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Create a new sale record
  Future<Map<String, dynamic>> createSale(Map<String, dynamic> saleData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/sales'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(saleData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create sale: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating sale: $e');
    }
  }

  // Get all sales or sales for a specific doctor
  Future<List<dynamic>> getSales({String? doctorId}) async {
    try {
      final queryParams = <String, String>{};
      
      if (doctorId != null) queryParams['doctorId'] = doctorId;

      final uri = Uri.parse('$baseUrl/api/sales').replace(queryParameters: queryParams);
      
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as List<dynamic>;
      } else {
        throw Exception('Failed to fetch sales: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching sales: $e');
    }
  }
} 