import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  late io.Socket socket;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isConnected = false;

  factory WebSocketService() {
    return _instance;
  }

  WebSocketService._internal();

  Future<void> connect() async {
    if (_isConnected) return;

    final token = await _storage.read(key: 'auth_token');
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

    socket = io.io(
      baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .enableAutoConnect()
          .enableReconnection()
          .build(),
    );

    _setupEventHandlers();
    socket.connect();
  }

  void _setupEventHandlers() {
    socket.onConnect((_) {
      _isConnected = true;
      log('WebSocket Connected', name: 'WebSocketService');
    });

    socket.onDisconnect((_) {
      _isConnected = false;
      log('WebSocket Disconnected', name: 'WebSocketService');
    });

    socket.onError((error) {
      log('WebSocket Error: $error', name: 'WebSocketService', level: 1000);
    });

    socket.onConnectError((error) {
      log('WebSocket Connect Error: $error',
          name: 'WebSocketService', level: 1000);
    });
  }

  // Join a room (e.g., for private chat or appointment)
  void joinRoom(String roomId) {
    if (_isConnected) {
      socket.emit('join_room', roomId);
    }
  }

  // Leave a room
  void leaveRoom(String roomId) {
    if (_isConnected) {
      socket.emit('leave_room', roomId);
    }
  }

  // Listen for messages in a specific room
  void onRoomMessage(String roomId, Function(dynamic) callback) {
    socket.on('message_$roomId', callback);
  }

  // Send a message to a specific room
  void sendMessage(String roomId, Map<String, dynamic> message) {
    if (_isConnected) {
      socket.emit('message', {'roomId': roomId, ...message});
    }
  }

  // Listen for appointment updates
  void onAppointmentUpdate(Function(dynamic) callback) {
    socket.on('appointment_update', callback);
  }

  // Listen for new notifications
  void onNewNotification(Function(dynamic) callback) {
    socket.on('notification', callback);
  }

  // Listen for online status changes
  void onUserStatusChange(Function(dynamic) callback) {
    socket.on('user_status_change', callback);
  }

  // Update user status
  void updateUserStatus(String status) {
    if (_isConnected) {
      socket.emit('update_status', status);
    }
  }

  // Clean up resources
  void dispose() {
    if (_isConnected) {
      socket.dispose();
      _isConnected = false;
    }
  }

  // Reconnect with new token
  Future<void> reconnectWithNewToken(String token) async {
    dispose();
    await _storage.write(key: 'auth_token', value: token);
    await connect();
  }

  // Check connection status
  bool get isConnected => _isConnected;
}
