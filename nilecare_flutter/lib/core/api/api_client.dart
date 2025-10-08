import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  late final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Rate limiting
  final _rateLimiter = RateLimiter();

  // Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  void initialize() {
    _dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment('API_BASE_URL',
          defaultValue: 'http://192.168.181.56:3000'),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.addAll([
      _authInterceptor(),
      _loggingInterceptor(),
      _retryInterceptor(),
    ]);
  }

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          final refreshToken = await _storage.read(key: 'refresh_token');
          if (refreshToken != null) {
            try {
              final newToken = await _refreshToken(refreshToken);
              await setAuthToken(newToken);
              // Retry the original request
              final opts = Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              );
              final response = await _dio.request(
                e.requestOptions.path,
                options: opts,
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );
              return handler.resolve(response);
            } catch (e) {
              await clearAuthToken();
              await clearRefreshToken();
              // Handle token refresh failure
            }
          }
        }
        return handler.next(e);
      },
    );
  }

  InterceptorsWrapper _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        print('REQUEST HEADERS: ${options.headers}');
        print('REQUEST DATA: ${options.data}');
        print('REQUEST QUERY PARAMS: ${options.queryParameters}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        print('RESPONSE DATA: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        print('ERROR TYPE: ${e.type}');
        print('ERROR MESSAGE: ${e.message}');
        print('ERROR DATA: ${e.response?.data}');
        print('REQUEST DATA: ${e.requestOptions.data}');
        print('REQUEST HEADERS: ${e.requestOptions.headers}');
        return handler.next(e);
      },
    );
  }

  InterceptorsWrapper _retryInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException e, handler) async {
        if (_shouldRetry(e)) {
          try {
            final response = await _retry(e.requestOptions);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(e as DioException);
          }
        }
        return handler.next(e);
      },
    );
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        (error.response?.statusCode ?? 0) >= 500;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<String> _refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      return response.data['token'];
    } catch (e) {
      throw ApiException('Failed to refresh token');
    }
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    await _rateLimiter.checkLimit();
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    await _rateLimiter.checkLimit();
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    await _rateLimiter.checkLimit();
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(String path) async {
    await _rateLimiter.checkLimit();
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> patch(String path, {dynamic data}) async {
    await _rateLimiter.checkLimit();
    try {
      final response = await _dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ApiException _handleError(DioException e) {
    print('Handling error: ${e.type}');
    print('Error response: ${e.response?.data}');

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timed out', statusCode: 408);
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          final message = data['message'] ?? data['error'] ?? 'Server error';
          print('Server error message: $message');
          return ApiException(
            message,
            statusCode: statusCode,
            data: data,
          );
        }
        return ApiException('Server error', statusCode: statusCode);
      case DioExceptionType.cancel:
        return ApiException('Request cancelled', statusCode: 499);
      default:
        return ApiException('Network error occurred', statusCode: 500);
    }
  }

  Future<void> setAuthToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<void> setRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  Future<void> clearAuthToken() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<void> clearRefreshToken() async {
    await _storage.delete(key: 'refresh_token');
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }
}

class RateLimiter {
  final _requests = <DateTime>[];
  static const int maxRequests = 100;
  static const Duration window = Duration(minutes: 1);

  Future<void> checkLimit() async {
    final now = DateTime.now();
    _requests.removeWhere((time) => now.difference(time) > window);

    if (_requests.length >= maxRequests) {
      final oldestRequest = _requests.first;
      final waitTime = window - now.difference(oldestRequest);
      await Future.delayed(waitTime);
    }

    _requests.add(now);
  }
}
