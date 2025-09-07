class Prescription {
  final String id;
  final String doctorId;
  final String patientId;
  final String appointmentId;
  final List<Medication> medications;
  final String diagnosis;
  final String instructions;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Prescription({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.appointmentId,
    required this.medications,
    required this.diagnosis,
    required this.instructions,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      appointmentId: json['appointmentId'],
      medications: (json['medications'] as List)
          .map((med) => Medication.fromJson(med))
          .toList(),
      diagnosis: json['diagnosis'],
      instructions: json['instructions'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'appointmentId': appointmentId,
      'medications': medications.map((med) => med.toJson()).toList(),
      'diagnosis': diagnosis,
      'instructions': instructions,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  final String? notes;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.notes,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      duration: json['duration'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'notes': notes,
    };
  }
}
