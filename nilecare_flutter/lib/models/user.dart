class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImage;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final List<String>? medicalHistory;
  final List<String>? allergies;
  final List<String>? medications;
  final String role; // 'patient', 'doctor', 'admin'
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime? emailVerifiedAt;
  final Map<String, dynamic>? roleData; // Additional data based on role
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.medicalHistory,
    this.allergies,
    this.medications,
    required this.role,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    this.emailVerifiedAt,
    this.roleData,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImage: json['profileImage'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      medicalHistory:
          (json['medicalHistory'] as List<dynamic>?)?.cast<String>(),
      allergies: (json['allergies'] as List<dynamic>?)?.cast<String>(),
      medications: (json['medications'] as List<dynamic>?)?.cast<String>(),
      role: json['role'] as String,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      emailVerifiedAt: json['emailVerifiedAt'] != null
          ? DateTime.parse(json['emailVerifiedAt'] as String)
          : null,
      roleData: json['roleData'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'address': address,
      'medicalHistory': medicalHistory,
      'allergies': allergies,
      'medications': medications,
      'role': role,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'emailVerifiedAt': emailVerifiedAt?.toIso8601String(),
      'roleData': roleData,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
