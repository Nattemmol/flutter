import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class MailService {
  final String baseUrl = ApiConfig.baseUrl;
  final Map<String, String> headers = ApiConfig.headers;

  // Send an email
  Future<Map<String, dynamic>> sendEmail({
    required String to,
    required String subject,
    required String html,
    List<Map<String, String>>? attachments,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/mail/send'),
        headers: {
          ...headers,
          'Authorization': 'Bearer ${await _getToken()}',
        },
        body: jsonEncode({
          'to': to,
          'subject': subject,
          'html': html,
          'attachments': attachments,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? 'Failed to send email');
      }
    } catch (e) {
      throw Exception('Error sending email: $e');
    }
  }

  Future<String> _getToken() async {
    // Implement token retrieval from secure storage
    // For now, return an empty string
    return '';
  }
}
