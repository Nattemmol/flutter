import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiUrl => dotenv.env['API_URL'] ?? 'http://localhost:3000';
  static String get socketUrl =>
      dotenv.env['SOCKET_URL'] ?? 'http://localhost:3001';
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  static String get firebaseMeasurementId =>
      dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';

  static Map<String, dynamic> get firebaseConfig => {
        'apiKey': firebaseApiKey,
        'appId': firebaseAppId,
        'messagingSenderId': firebaseMessagingSenderId,
        'projectId': firebaseProjectId,
        'storageBucket': firebaseStorageBucket,
        'authDomain': firebaseAuthDomain,
        'measurementId': firebaseMeasurementId,
      };
}
