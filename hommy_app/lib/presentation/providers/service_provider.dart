import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/service_model.dart';
import '../../data/repositories/service_repository.dart';

// Repository provider
final serviceRepositoryProvider = Provider((ref) => ServiceRepository());

// Active services provider
final activeServicesProvider = FutureProvider<List<ServiceModel>>((ref) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getActiveServices();
});

// User services provider
final userServicesProvider = FutureProvider.family<List<ServiceModel>, String>((ref, userId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getUserServices(userId);
});

// Service detail provider
final serviceDetailProvider = FutureProvider.family<ServiceModel?, String>((ref, serviceId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getServiceById(serviceId);
});

// Categories provider
final categoriesProvider = FutureProvider<List<Map((ref) async<String, dynamic>>> {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getCategories();
});

// Services by category
final servicesByCategoryProvider = FutureProvider.family<List<ServiceModel>, String>((ref, categoryId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getActiveServices(categoryId: categoryId);
});

// Services notifier for CRUD operations
class ServicesNotifier extends StateNotifier<AsyncValue<List<ServiceModel>>> {
  final ServiceRepository _repository;
  final String? _userId;

  ServicesNotifier(this._repository, this._userId) : super(const AsyncValue.loading()) {
    if (_userId != null) {
      _loadUserServices();
    } else {
      _loadActiveServices();
    }
  }

  Future<void> _loadUserServices() async {
    if (_userId == null) return;
    state = const AsyncValue.loading();
    try {
      final services = await _repository.getUserServices(_userId!);
      state = AsyncValue.data(services);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> _loadActiveServices() async {
    state = const AsyncValue.loading();
    try {
      final services = await _repository.getActiveServices();
      state = AsyncValue.data(services);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createService(ServiceModel service) async {
    try {
      await _repository.createService(service);
      await refresh();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateService(String serviceId, Map<String, dynamic> data) async {
    try {
      await _repository.updateService(serviceId, data);
      await refresh();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await _repository.deleteService(serviceId);
      await refresh();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    if (_userId != null) {
      await _loadUserServices();
    } else {
      await _loadActiveServices();
    }
  }
}

final servicesNotifierProvider = StateNotifierProvider<ServicesNotifier, AsyncValue<List<ServiceModel>>>((ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return ServicesNotifier(repository, null);
});
