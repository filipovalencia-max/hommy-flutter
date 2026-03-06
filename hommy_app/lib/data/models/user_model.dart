class UserModel {
  final String id;
  final String userId;
  final String email;
  final String name;
  final String userType;
  final String? phone;
  final DateTime? birthDate;
  final String? profilePictureUrl;
  final bool isActive;
  final double balance;
  final bool movilVerificado;
  final bool whatsappNotificationsEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.userId,
    required this.email,
    required this.name,
    required this.userType,
    this.phone,
    this.birthDate,
    this.profilePictureUrl,
    this.isActive = true,
    this.balance = 0,
    this.movilVerificado = false,
    this.whatsappNotificationsEnabled = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      userType: json['user_type'] ?? 'user',
      phone: json['phone'],
      birthDate: json['birth_date'] != null 
          ? DateTime.parse(json['birth_date']) 
          : null,
      profilePictureUrl: json['profile_picture_url'],
      isActive: json['is_active'] ?? true,
      balance: (json['balance'] ?? 0).toDouble(),
      movilVerificado: json['movil_verificado'] ?? false,
      whatsappNotificationsEnabled: json['whatsapp_notifications_enabled'] ?? true,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'email': email,
      'name': name,
      'user_type': userType,
      'phone': phone,
      'birth_date': birthDate?.toIso8601String(),
      'profile_picture_url': profilePictureUrl,
      'is_active': isActive,
      'balance': balance,
      'movil_verificado': movilVerificado,
      'whatsapp_notifications_enabled': whatsappNotificationsEnabled,
    };
  }

  UserModel copyWith({
    String? id,
    String? userId,
    String? email,
    String? name,
    String? userType,
    String? phone,
    DateTime? birthDate,
    String? profilePictureUrl,
    bool? isActive,
    double? balance,
    bool? movilVerificado,
    bool? whatsappNotificationsEnabled,
  }) {
    return UserModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      isActive: isActive ?? this.isActive,
      balance: balance ?? this.balance,
      movilVerificado: movilVerificado ?? this.movilVerificado,
      whatsappNotificationsEnabled: whatsappNotificationsEnabled ?? this.whatsappNotificationsEnabled,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
