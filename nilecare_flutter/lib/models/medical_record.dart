class MedicalRecord {
  final String id;
  final String patientId;
  final String doctorId;
  final String appointmentId;
  final String chiefComplaint;
  final String diagnosis;
  final String treatment;
  final List<String> attachments;
  final List<String> labResults;
  final String notes;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  MedicalRecord({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentId,
    required this.chiefComplaint,
    required this.diagnosis,
    required this.treatment,
    required this.attachments,
    required this.labResults,
    required this.notes,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      appointmentId: json['appointmentId'],
      chiefComplaint: json['chiefComplaint'],
      diagnosis: json['diagnosis'],
      treatment: json['treatment'],
      attachments: List<String>.from(json['attachments']),
      labResults: List<String>.from(json['labResults']),
      notes: json['notes'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentId': appointmentId,
      'chiefComplaint': chiefComplaint,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'attachments': attachments,
      'labResults': labResults,
      'notes': notes,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
