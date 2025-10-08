import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadThingService {
  final String baseUrl;
  final String apiKey;

  UploadThingService({
    required this.baseUrl,
    required this.apiKey,
  });

  // Upload a file
  Future<Map<String, dynamic>> uploadFile({
    required File file,
    String? fileName,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/uploadthing'),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add file
      final fileStream = http.ByteStream(file.openRead());
      final fileLength = await file.length();
      final multipartFile = http.MultipartFile(
        'file',
        fileStream,
        fileLength,
        filename: fileName ?? file.path.split('/').last,
      );
      request.files.add(multipartFile);

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        throw Exception('Failed to upload file: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  // Upload multiple files
  Future<List<Map<String, dynamic>>> uploadFiles({
    required List<File> files,
    List<String>? fileNames,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      // Create multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/uploadthing/multiple'),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add files
      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final fileStream = http.ByteStream(file.openRead());
        final fileLength = await file.length();
        final fileName = fileNames != null && i < fileNames.length
            ? fileNames[i]
            : file.path.split('/').last;
        
        final multipartFile = http.MultipartFile(
          'files',
          fileStream,
          fileLength,
          filename: fileName,
        );
        request.files.add(multipartFile);
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to upload files: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error uploading files: $e');
    }
  }

  // Delete a file
  Future<void> deleteFile(String fileUrl) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/uploadthing'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'fileUrl': fileUrl,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete file: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting file: $e');
    }
  }

  // Helper method for token management
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
} 