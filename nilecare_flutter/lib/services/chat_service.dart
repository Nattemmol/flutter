import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../core/api/api_client.dart';
import '../core/config/app_config.dart';

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String type; // 'text', 'image', 'file'
  final String? fileUrl;
  final DateTime createdAt;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    this.fileUrl,
    required this.createdAt,
    required this.isRead,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      type: json['type'],
      fileUrl: json['fileUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': type,
      'fileUrl': fileUrl,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }
}

class ChatService {
  final ApiClient _apiClient = ApiClient();
  late IO.Socket _socket;

  void initialize(String userId) {
    _socket = IO.io(AppConfig.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'userId': userId},
    });

    _socket.connect();
    _setupSocketListeners();
  }

  void _setupSocketListeners() {
    _socket.onConnect((_) {
      print('Connected to chat server');
    });

    _socket.onDisconnect((_) {
      print('Disconnected from chat server');
    });

    _socket.onError((error) {
      print('Socket error: $error');
    });
  }

  // Send a message
  Future<Message> sendMessage({
    required String receiverId,
    required String content,
    required String type,
    String? fileUrl,
  }) async {
    try {
      final response = await _apiClient.post(
        '/api/messages',
        data: {
          'receiverId': receiverId,
          'content': content,
          'type': type,
          if (fileUrl != null) 'fileUrl': fileUrl,
        },
      );

      final message = Message.fromJson(response['data']);
      _socket.emit('new_message', message.toJson());
      return message;
    } on DioException catch (e) {
      throw _handleChatError(e);
    }
  }

  // Get chat history
  Future<List<Message>> getChatHistory(String otherUserId) async {
    try {
      final response = await _apiClient.get(
        '/api/messages',
        queryParameters: {'userId': otherUserId},
      );
      final List<dynamic> messagesJson = response['data'];
      return messagesJson.map((json) => Message.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleChatError(e);
    }
  }

  // Mark message as read
  Future<void> markMessageAsRead(String messageId) async {
    try {
      await _apiClient.put('/api/messages/$messageId/read');
      _socket.emit('message_read', {'messageId': messageId});
    } on DioException catch (e) {
      throw _handleChatError(e);
    }
  }

  // Upload file for chat
  Future<String> uploadFile(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiClient.post(
        '/api/messages/upload',
        data: formData,
      );
      return response['data']['fileUrl'];
    } on DioException catch (e) {
      throw _handleChatError(e);
    }
  }

  // Listen for new messages
  void onNewMessage(Function(Message) callback) {
    _socket.on('new_message', (data) {
      final message = Message.fromJson(data);
      callback(message);
    });
  }

  // Listen for message read status
  void onMessageRead(Function(String) callback) {
    _socket.on('message_read', (data) {
      callback(data['messageId']);
    });
  }

  // Disconnect from chat server
  void disconnect() {
    _socket.disconnect();
  }

  // Error handling
  Exception _handleChatError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Chat operation failed: ${e.message}');
  }
}
