import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl {
    // First try to get from environment variable
    final envUrl = dotenv.env['API_BASE_URL'];
    if (envUrl != null && envUrl.isNotEmpty) {
      return envUrl;
    }

    // Fallback URLs based on platform
    if (kIsWeb) {
      return 'http://192.168.181.56:3000';
    } else if (Platform.isAndroid) {
      // Check if running on an emulator
      if (Platform.environment.containsKey('ANDROID_EMULATOR')) {
        return 'http://10.0.2.2:3000';
      } else {
        // Running on a physical Android device
        return 'http://192.168.181.56:3000';
      }
    } else {
      // iOS or other platforms
      return 'http://192.168.181.56:3000';
    }
  }

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static const String apiKey = 'YOUR_API_KEY';

  // Add other configuration constants as needed
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;

  // API endpoints
  static const String authEndpoint = '/api/auth';
  static const String usersEndpoint = '/api/users';
  static const String appointmentsEndpoint = '/api/appointments';
  static const String doctorsEndpoint = '/api/doctors';
  static const String statsEndpoint = '/api/stats';
  static const String specialtiesEndpoint = '/api/specialties';
  static const String salesEndpoint = '/api/sales';
  static const String onboardingEndpoint = '/api/onboarding';
  static const String mailEndpoint = '/api/mail';
  static const String hmsEndpoint = '/api/hms';
  static const String chapaEndpoint = '/api/chapa';
  static const String verifyChapaEndpoint = '/api/verify-chapa';
  static const String uploadThingEndpoint = '/api/upload-thing';
}
