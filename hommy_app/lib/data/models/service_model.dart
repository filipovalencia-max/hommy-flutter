enum ServiceStatus { active, hired, inProgress, completed, cancelled, deleted }

class ServiceModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? categoryId;
  final String? location;
  final ServiceStatus status;
  final List<String> images;
  final String? completionPin;
  final DateTime? pinGeneratedAt;
  final double? escrowAmount;
  final double? workerFinalAmount;
  final String? workerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.categoryId,
    this.location,
    this.status = ServiceStatus.active,
    this.images = const [],
    this.completionPin,
    this.pinGeneratedAt,
    this.escrowAmount,
    this.workerFinalAmount,
    this.workerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      categoryId: json['category_id'],
      location: json['location'],
      status: _parseStatus(json['status']),
      images: json['images'] != null 
          ? List<String>.from(json['images']) 
          : [],
      completionPin: json['completion_pin'],
      pinGeneratedAt: json['pin_generated_at'] != null 
          ? DateTime.parse(json['pin_generated_at']) 
          : null,
      escrowAmount: json['escrow_amount']?.toDouble(),
      workerFinalAmount: json['worker_final_amount']?.toDouble(),
      workerId: json['worker_id'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  static ServiceStatus _parseStatus(String? status) {
    switch (status) {
      case 'active': return ServiceStatus.active;
      case 'hired': return ServiceStatus.hired;
      case 'in_progress': return ServiceStatus.inProgress;
      case 'completed': return ServiceStatus.completed;
      case 'cancelled': return ServiceStatus.cancelled;
      case 'deleted': return ServiceStatus.deleted;
      default: return ServiceStatus.active;
    }
  }

  String get statusString {
    switch (status) {
      case ServiceStatus.active: return 'active';
      case ServiceStatus.hired: return 'hired';
      case ServiceStatus.inProgress: return 'in_progress';
      case ServiceStatus.completed: return 'completed';
      case ServiceStatus.cancelled: return 'cancelled';
      case ServiceStatus.deleted: return 'deleted';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'location': location,
      'status': statusString,
      'images': images,
      'worker_id': workerId,
    };
  }
}
