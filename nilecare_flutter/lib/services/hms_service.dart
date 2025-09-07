import 'dart:convert';
import 'package:http/http.dart' as http;

class HMSService {
  final String baseUrl;
  final String apiKey;

  HMSService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Generate a secure token for HMS
  Future<String> generateToken({
    required String roomId,
    required String userName,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/hms/token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'roomId': roomId,
          'userName': userName,
          'role': role,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'] as String;
      } else {
        throw Exception('Failed to generate token: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error generating token: $e');
    }
  }

  // Create a new HMS room
  Future<String> createRoom({String? roomName}) async {
    try {
      final queryParams = <String, String>{};
      if (roomName != null) {
        queryParams['roomName'] = roomName;
      }

      final uri = Uri.parse('$baseUrl/api/hms/room').replace(queryParameters: queryParams);
      
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['roomId'] as String;
      } else {
        throw Exception('Failed to create room: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating room: $e');
    }
  }

  // Join an HMS room (combines token generation and room creation if needed)
  Future<Map<String, String>> joinRoom({
    String? roomId,
    required String userName,
    required String role,
    String? roomName,
  }) async {
    try {
      // If roomId is not provided, create a new room
      final actualRoomId = roomId ?? await createRoom(roomName: roomName);
      
      // Generate token for the room
      final token = await generateToken(
        roomId: actualRoomId,
        userName: userName,
        role: role,
      );

      return {
        'roomId': actualRoomId,
        'token': token,
      };
    } catch (e) {
      throw Exception('Error joining room: $e');
    }
  }
} 