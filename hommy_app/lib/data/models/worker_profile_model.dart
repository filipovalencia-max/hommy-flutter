class WorkerProfileModel {
  final String id;
  final String userId;
  final String profession;
  final int experienceYears;
  final String? bio;
  final String? profileDescription;
  final List<String> categories;
  final List<String> certifications;
  final double? hourlyRate;
  final double rating;
  final int totalServices;
  final bool isVerified;
  final bool isAvailable;
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;

  WorkerProfileModel({
    required this.id,
    required this.userId,
    required this.profession,
    this.experienceYears = 0,
    this.bio,
    this.profileDescription,
    this.categories = const [],
    this.certifications = const [],
    this.hourlyRate,
    this.rating = 0,
    this.totalServices = 0,
    this.isVerified = false,
    this.isAvailable = true,
    this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WorkerProfileModel.fromJson(Map<String, dynamic> json) {
    return WorkerProfileModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      profession: json['profession'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      bio: json['bio'],
      profileDescription: json['profile_description'],
      categories: json['categories'] != null 
          ? List<String>.from(json['categories']) 
          : [],
      certifications: json['certifications'] != null 
          ? List<String>.from(json['certifications']) 
          : [],
      hourlyRate: json['hourly_rate']?.toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      totalServices: json['total_services'] ?? 0,
      isVerified: json['is_verified'] ?? false,
      isAvailable: json['is_available'] ?? true,
      location: json['location'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'profession': profession,
      'experience_years': experienceYears,
      'bio': bio,
      'profile_description': profileDescription,
      'categories': categories,
      'certifications': certifications,
      'hourly_rate': hourlyRate,
      'is_available': isAvailable,
      'location': location,
    };
  }
}
