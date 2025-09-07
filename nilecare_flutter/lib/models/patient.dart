class Patient {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String gender;
  final String? profileImage;
  final String? address;
  final List<String> medicalHistory;
  final List<String> allergies;
  final List<String> medications;
  final DateTime createdAt;
  final DateTime updatedAt;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    this.profileImage,
    this.address,
    required this.medicalHistory,
    required this.allergies,
    required this.medications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      profileImage: json['profileImage'],
      address: json['address'],
      medicalHistory: List<String>.from(json['medicalHistory']),
      allergies: List<String>.from(json['allergies']),
      medications: List<String>.from(json['medications']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'profileImage': profileImage,
      'address': address,
      'medicalHistory': medicalHistory,
      'allergies': allergies,
      'medications': medications,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
