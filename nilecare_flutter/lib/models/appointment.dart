import '../models/doctor.dart';

enum AppointmentStatus { scheduled, confirmed, completed, cancelled, noShow }

class Appointment {
  final String id;
  final String doctorId;
  final String patientId;
  final String serviceId;
  final DateTime dateTime;
  final String type;
  final String status;
  final double amount;
  final String currency;
  final bool isPaid;
  final String? location;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Doctor? doctor;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.serviceId,
    required this.dateTime,
    required this.type,
    required this.status,
    required this.amount,
    required this.currency,
    required this.isPaid,
    this.location,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.doctor,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      doctorId: json['doctorId'] as String,
      patientId: json['patientId'] as String,
      serviceId: json['serviceId'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      type: json['type'] as String,
      status: json['status'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      isPaid: json['isPaid'] as bool,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      doctor: json['doctor'] != null
          ? Doctor.fromJson(json['doctor'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'serviceId': serviceId,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'status': status,
      'amount': amount,
      'currency': currency,
      'isPaid': isPaid,
      'location': location,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'doctor': doctor?.toJson(),
    };
  }
}
