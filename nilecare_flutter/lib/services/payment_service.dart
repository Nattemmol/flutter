import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class Payment {
  final String id;
  final String appointmentId;
  final double amount;
  final String currency;
  final String status;
  final String paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
    required this.id,
    required this.appointmentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      appointmentId: json['appointmentId'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointmentId': appointmentId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class PaymentService {
  final ApiClient _apiClient = ApiClient();

  // Initialize payment
  Future<Map<String, dynamic>> initializePayment({
    required String appointmentId,
    required double amount,
    required String currency,
    required String paymentMethod,
  }) async {
    try {
      final response = await _apiClient.post(
        '/api/payments/initialize',
        data: {
          'appointmentId': appointmentId,
          'amount': amount,
          'currency': currency,
          'paymentMethod': paymentMethod,
        },
      );
      return response['data'];
    } on DioException catch (e) {
      throw _handlePaymentError(e);
    }
  }

  // Verify payment
  Future<Payment> verifyPayment(String paymentId) async {
    try {
      final response = await _apiClient.post(
        '/api/payments/$paymentId/verify',
      );
      return Payment.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handlePaymentError(e);
    }
  }

  // Get payment details
  Future<Payment> getPaymentDetails(String paymentId) async {
    try {
      final response = await _apiClient.get('/api/payments/$paymentId');
      return Payment.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handlePaymentError(e);
    }
  }

  // Get payment history
  Future<List<Payment>> getPaymentHistory({
    String? appointmentId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (appointmentId != null) queryParams['appointmentId'] = appointmentId;
      if (status != null) queryParams['status'] = status;
      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }

      final response = await _apiClient.get(
        '/api/payments',
        queryParameters: queryParams,
      );
      final List<dynamic> paymentsJson = response['data'];
      return paymentsJson.map((json) => Payment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handlePaymentError(e);
    }
  }

  // Refund payment
  Future<Payment> refundPayment(String paymentId, {double? amount}) async {
    try {
      final response = await _apiClient.post(
        '/api/payments/$paymentId/refund',
        data: amount != null ? {'amount': amount} : null,
      );
      return Payment.fromJson(response['data']);
    } on DioException catch (e) {
      throw _handlePaymentError(e);
    }
  }

  // Error handling
  Exception _handlePaymentError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final message = e.response?.data['message'] as String?;
      if (message != null) {
        return Exception(message);
      }
    }
    return Exception('Payment operation failed: ${e.message}');
  }
}
