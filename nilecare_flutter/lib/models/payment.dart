class Payment {
  final String id;
  final String patientId;
  final String appointmentId;
  final double amount;
  final String currency;
  final String status; // 'pending', 'completed', 'failed'
  final String paymentMethod;
  final String? transactionId;
  final String? receiptUrl;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Payment({
    required this.id,
    required this.patientId,
    required this.appointmentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    this.transactionId,
    this.receiptUrl,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      patientId: json['patientId'],
      appointmentId: json['appointmentId'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      transactionId: json['transactionId'],
      receiptUrl: json['receiptUrl'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'appointmentId': appointmentId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'receiptUrl': receiptUrl,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
