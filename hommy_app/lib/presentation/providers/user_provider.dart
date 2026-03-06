import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user_model.dart';
import '../data/models/worker_profile_model.dart';
import '../data/repositories/user_repository.dart';

// Repository provider
final userRepositoryProvider = Provider((ref) => UserRepository());

// Current user provider
final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getCurrentUserProfile();
});

// Worker profile provider
final workerProfileProvider = FutureProvider.family<WorkerProfileModel?, String>((ref, userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getWorkerProfile(userId);
});

// All workers provider
final allWorkersProvider = FutureProvider<List<WorkerProfileModel>>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getAllWorkers();
});

// Workers search provider
final workersSearchProvider = FutureProvider.family<List<WorkerProfileModel>, String>((ref, category) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.searchWorkers(category: category);
});

// Auth state notifier
class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final UserRepository _repository;

  AuthNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.getCurrentUserProfile();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _loadUser();
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final currentUser = state.value;
    if (currentUser == null) return;
    
    await _repository.updateProfile(currentUser.userId, data);
    await refresh();
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return AuthNotifier(repository);
});
