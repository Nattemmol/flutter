import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/api/api_client.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';

// Response Models
class AuthResponse {
  final String token;
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  User? _currentUser;
  bool _isInitialized = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isEmailVerified => _currentUser?.isEmailVerified ?? false;
  bool get isDoctor => _currentUser?.role == 'doctor';
  bool get isPatient => _currentUser?.role == 'patient';
  bool get isAdmin => _currentUser?.role == 'admin';

  Future<void> initialize() async {
    if (_isInitialized) return;

    final token = await _apiClient.getAuthToken();
    if (token != null) {
      try {
        await _fetchUserProfile();
      } catch (e) {
        await logout();
      }
    }
    _isInitialized = true;
  }

  Future<User> login({required String email, required String password}) async {
    try {
      final response = await _apiClient.post(
        '/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final user = User.fromJson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final response = await _apiClient.post(
        '/api/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        },
      );

      final user = User.fromJson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/api/auth/logout');
      _currentUser = null;
    } on DioException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _apiClient.post(
        '/api/auth/reset-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiClient.put(
        '/api/auth/change-password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<User> updateProfile({
    String? name,
    String? profileImage,
    Map<String, dynamic>? roleData,
  }) async {
    try {
      final response = await _apiClient.put('/api/auth/profile', data: {
        if (name != null) 'name': name,
        if (profileImage != null) 'profileImage': profileImage,
        if (roleData != null) 'roleData': roleData,
      });

      _currentUser = User.fromJson(response['data']);
      return _currentUser!;
    } catch (e) {
      throw _handleAuthError(e as DioException);
    }
  }

  // Email verification
  Future<void> sendVerificationEmail() async {
    try {
      await _apiClient.post('/api/auth/send-verification-email');
    } catch (e) {
      throw _handleAuthError(e as DioException);
    }
  }

  Future<void> verifyEmail(String token) async {
    try {
      final response = await _apiClient.post('/api/auth/verify-email', data: {
        'token': token,
      });

      _currentUser = User.fromJson(response['data']);
    } catch (e) {
      throw _handleAuthError(e as DioException);
    }
  }

  // Role-specific methods
  Future<Map<String, dynamic>> getDoctorProfile() async {
    if (!isDoctor) {
      throw Exception('User is not a doctor');
    }

    try {
      final response = await _apiClient.get('/api/auth/doctor-profile');
      return response['data'];
    } catch (e) {
      throw _handleAuthError(e as DioException);
    }
  }

  Future<Map<String, dynamic>> getPatientProfile() async {
    if (!isPatient) {
      throw Exception('User is not a patient');
    }

    try {
      final response = await _apiClient.get('/api/auth/patient-profile');
      return response['data'];
    } catch (e) {
      throw _handleAuthError(e as DioException);
    }
  }

  Future<User> getCurrentUser() async {
    if (_currentUser != null) {
      return _currentUser!;
    }

    try {
      final response = await _apiClient.get('/api/auth/me');
      final user = User.fromJson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> _handleAuthResponse(Map<String, dynamic> response) async {
    final token = response['token'];
    final refreshToken = response['refreshToken'];
    final user = User.fromJson(response['data']);

    await _apiClient.setAuthToken(token);
    await _apiClient.setRefreshToken(refreshToken);
    await _storage.write(key: 'user', value: jsonEncode(user.toJson()));

    _currentUser = user;
  }

  Future<void> _clearAuthData() async {
    await _apiClient.clearAuthToken();
    await _apiClient.clearRefreshToken();
    await _storage.delete(key: 'user');
    _currentUser = null;
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await _apiClient.get('/api/auth/profile');
      _currentUser = User.fromJson(response['data']);
    } catch (e) {
      throw _handleAuthError(e as DioException);
    }
  }

  Exception _handleAuthError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Authentication failed: ${e.message}');
  }
}
