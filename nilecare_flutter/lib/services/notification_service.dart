import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../core/api/api_client.dart';
import '../core/config/app_config.dart';

class NotificationService {
  final ApiClient _apiClient = ApiClient();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize Firebase
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: AppConfig.firebaseApiKey,
        appId: AppConfig.firebaseAppId,
        messagingSenderId: AppConfig.firebaseMessagingSenderId,
        projectId: AppConfig.firebaseProjectId,
        storageBucket: AppConfig.firebaseStorageBucket,
        authDomain: AppConfig.firebaseAuthDomain,
        measurementId: AppConfig.firebaseMeasurementId,
      ),
    );

    // Request permission for notifications
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get FCM token
      final token = await _messaging.getToken();
      if (token != null) {
        await _registerDeviceToken(token);
      }

      // Listen for token refresh
      _messaging.onTokenRefresh.listen(_registerDeviceToken);

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    }

    _isInitialized = true;
  }

  Future<void> _registerDeviceToken(String token) async {
    try {
      await _apiClient.post(
        '/api/notifications/register-device',
        data: {'token': token},
      );
    } on DioException catch (e) {
      throw _handleNotificationError(e);
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
    } catch (e) {
      throw Exception('Failed to subscribe to topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
    } catch (e) {
      throw Exception('Failed to unsubscribe from topic: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Handle foreground message
    // You can show a local notification or update UI
    print('Received foreground message: ${message.data}');
  }

  Exception _handleNotificationError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Notification operation failed: ${e.message}');
  }
}

// This needs to be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background message
  print('Received background message: ${message.data}');
}
