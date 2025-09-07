class Doctor {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String specialization;
  final String serviceId;
  final double consultationFee;
  final String? profileImage;
  final String? bio;
  final List<String>? languages;
  final List<String>? certifications;
  final double? rating;
  final int? reviewCount;
  final int? experience;
  final List<Review>? reviews;
  final DateTime createdAt;
  final DateTime updatedAt;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.specialization,
    required this.serviceId,
    required this.consultationFee,
    this.profileImage,
    this.bio,
    this.languages,
    this.certifications,
    this.rating,
    this.reviewCount,
    this.experience,
    this.reviews,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      specialization: json['specialization'] as String,
      serviceId: json['serviceId'] as String,
      consultationFee: (json['consultationFee'] as num).toDouble(),
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      languages: (json['languages'] as List<dynamic>?)?.cast<String>(),
      certifications:
          (json['certifications'] as List<dynamic>?)?.cast<String>(),
      rating: json['rating'] as double?,
      reviewCount: json['reviewCount'] as int?,
      experience: json['experience'] as int?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'specialization': specialization,
      'serviceId': serviceId,
      'consultationFee': consultationFee,
      'profileImage': profileImage,
      'bio': bio,
      'languages': languages,
      'certifications': certifications,
      'rating': rating,
      'reviewCount': reviewCount,
      'experience': experience,
      'reviews': reviews?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Review {
  final String id;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      rating: json['rating'] as double,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
