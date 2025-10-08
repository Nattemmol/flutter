import 'dart:convert';
import 'package:http/http.dart' as http;

class InboxService {
  final String baseUrl;
  final String apiKey;

  InboxService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Get inbox messages for a receiver
  Future<List<dynamic>> getInboxMessages(String receiverId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/inbox?receiverId=$receiverId'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as List<dynamic>;
      } else {
        throw Exception('Failed to fetch inbox messages: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching inbox messages: $e');
    }
  }

  // Get sent messages by a sender
  Future<List<dynamic>> getSentMessages(String senderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/inbox?senderId=$senderId'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as List<dynamic>;
      } else {
        throw Exception('Failed to fetch sent messages: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching sent messages: $e');
    }
  }

  // Get a specific message by ID
  Future<Map<String, dynamic>> getMessageById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/inbox/$id'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch message: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching message: $e');
    }
  }

  // Create a new inbox message
  Future<Map<String, dynamic>> createMessage({
    required String senderId,
    required String receiverId,
    String? subject,
    required String message,
    bool isRead = false,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/inbox'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'senderId': senderId,
          'recieverId': receiverId,
          'subject': subject,
          'message': message,
          'isRead': isRead,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create message: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating message: $e');
    }
  }

  // Update a message
  Future<Map<String, dynamic>> updateMessage(
    String id, {
    String? subject,
    String? message,
    bool? isRead,
  }) async {
    try {
      final Map<String, dynamic> updateData = {};
      
      if (subject != null) updateData['subject'] = subject;
      if (message != null) updateData['message'] = message;
      if (isRead != null) updateData['isRead'] = isRead;

      final response = await http.put(
        Uri.parse('$baseUrl/api/inbox/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update message: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating message: $e');
    }
  }

  // Delete a message
  Future<bool> deleteMessage(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/inbox/$id'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete message: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting message: $e');
    }
  }
} 