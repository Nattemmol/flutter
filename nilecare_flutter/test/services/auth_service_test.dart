import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:nilecare_flutter/services/auth_service.dart';
import 'package:nilecare_flutter/core/api/api_client.dart';

// Manual mocks
class MockApiClient extends Mock implements ApiClient {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthService authService;
  late MockApiClient mockApiClient;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockApiClient = MockApiClient();
    mockStorage = MockFlutterSecureStorage();
    authService = AuthService();
  });

  group('Authentication Service Tests', () {
    test('Login success', () async {
      final mockResponse = {
        'token': 'test-token',
        'refreshToken': 'test-refresh-token',
        'user': {
          'id': '1',
          'email': 'test@example.com',
          'name': 'Test User',
          'role': 'patient',
          'profileImage': null,
          'createdAt': '2024-01-01T00:00:00.000Z',
          'updatedAt': '2024-01-01T00:00:00.000Z',
        },
      };

      when(mockApiClient.post('/auth/login', data: {
        'email': 'test@example.com',
        'password': 'password123',
      })).thenAnswer((_) async => mockResponse);

      final user = await authService.login(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(user.id, '1');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.role, 'patient');
    });

    test('Login failure', () async {
      when(mockApiClient.post('/auth/login', data: {
        'email': 'test@example.com',
        'password': 'wrong-password',
      })).thenThrow(ApiException('Invalid credentials'));

      expect(
        () => authService.login(
          email: 'test@example.com',
          password: 'wrong-password',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Register success', () async {
      final mockResponse = {
        'token': 'test-token',
        'refreshToken': 'test-refresh-token',
        'user': {
          'id': '1',
          'email': 'new@example.com',
          'name': 'New User',
          'role': 'patient',
          'profileImage': null,
          'createdAt': '2024-01-01T00:00:00.000Z',
          'updatedAt': '2024-01-01T00:00:00.000Z',
        },
      };

      when(mockApiClient.post('/auth/register', data: {
        'email': 'new@example.com',
        'password': 'password123',
        'name': 'New User',
        'phoneNumber': '1234567890',
      })).thenAnswer((_) async => mockResponse);

      final user = await authService.register(
        email: 'new@example.com',
        password: 'password123',
        name: 'New User',
        phoneNumber: '1234567890',
      );

      expect(user.id, '1');
      expect(user.email, 'new@example.com');
      expect(user.name, 'New User');
    });

    test('Logout success', () async {
      when(mockApiClient.post('/auth/logout')).thenAnswer((_) async => {});

      await authService.logout();

      verify(mockApiClient.clearAuthToken()).called(1);
      verify(mockApiClient.clearRefreshToken()).called(1);
    });

    test('Update profile success', () async {
      final mockResponse = {
        'user': {
          'id': '1',
          'email': 'test@example.com',
          'name': 'Updated Name',
          'role': 'patient',
          'profileImage': 'new-image.jpg',
          'createdAt': '2024-01-01T00:00:00.000Z',
          'updatedAt': '2024-01-01T00:00:00.000Z',
        },
      };

      when(mockApiClient.put('/auth/profile', data: {
        'name': 'Updated Name',
        'profileImage': 'new-image.jpg',
      })).thenAnswer((_) async => mockResponse);

      final user = await authService.updateProfile(
        name: 'Updated Name',
        profileImage: 'new-image.jpg',
      );

      expect(user.name, 'Updated Name');
      expect(user.profileImage, 'new-image.jpg');
    });

    test('Reset password success', () async {
      when(mockApiClient.post('/auth/reset-password', data: {
        'email': 'test@example.com',
      })).thenAnswer((_) async => {});

      await authService.resetPassword(email: 'test@example.com');
      // No exception means success
    });

    test('Initialize with valid token', () async {
      when(mockApiClient.getAuthToken()).thenAnswer((_) async => 'valid-token');
      when(mockApiClient.get('/auth/profile')).thenAnswer((_) async => {
            'user': {
              'id': '1',
              'email': 'test@example.com',
              'name': 'Test User',
              'role': 'patient',
              'profileImage': null,
              'createdAt': '2024-01-01T00:00:00.000Z',
              'updatedAt': '2024-01-01T00:00:00.000Z',
            },
          });

      await authService.initialize();
      expect(authService.isAuthenticated, true);
      expect(authService.currentUser?.email, 'test@example.com');
    });

    test('Initialize with invalid token', () async {
      when(mockApiClient.getAuthToken())
          .thenAnswer((_) async => 'invalid-token');
      when(mockApiClient.get('/auth/profile'))
          .thenThrow(ApiException('Invalid token'));

      await authService.initialize();
      expect(authService.isAuthenticated, false);
      expect(authService.currentUser, null);
    });
  });
}
