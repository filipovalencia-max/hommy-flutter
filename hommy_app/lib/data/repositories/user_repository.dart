import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../models/worker_profile_model.dart';

class UserRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Obtener perfil del usuario actual
  Future<UserModel?> getCurrentUserProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final response = await _client
        .from('profiles_v2')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();

    if (response == null) return null;
    return UserModel.fromJson(response);
  }

  // Obtener perfil por ID de usuario
  Future<UserModel?> getProfileByUserId(String userId) async {
    final response = await _client
        .from('profiles_v2')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserModel.fromJson(response);
  }

  // Crear perfil de usuario
  Future<void> createProfile(UserModel profile) async {
    await _client.from('profiles_v2').insert({
      'user_id': profile.userId,
      'email': profile.email,
      'name': profile.name,
      'user_type': profile.userType,
      'phone': profile.phone,
    });
  }

  // Actualizar perfil
  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    await _client
        .from('profiles_v2')
        .update(data)
        .eq('user_id', userId);
  }

  // Obtener perfil de trabajador
  Future<WorkerProfileModel?> getWorkerProfile(String userId) async {
    final response = await _client
        .from('worker_profiles_v2')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return WorkerProfileModel.fromJson(response);
  }

  // Crear perfil de trabajador
  Future<void> createWorkerProfile(WorkerProfileModel profile) async {
    await _client.from('worker_profiles_v2').insert(profile.toJson());
  }

  // Actualizar perfil de trabajador
  Future<void> updateWorkerProfile(String userId, Map<String, dynamic> data) async {
    await _client
        .from('worker_profiles_v2')
        .update(data)
        .eq('user_id', userId);
  }

  // Buscar trabajadores por categoría
  Future<List<WorkerProfileModel>> searchWorkers({
    String? category,
    String? location,
    int limit = 20,
  }) async {
    var query = _client
        .from('worker_profiles_v2')
        .select()
        .eq('is_available', true)
        .limit(limit);

    if (category != null) {
      query = query.contains('categories', [category]);
    }
    if (location != null) {
      query = query.eq('location', location);
    }

    final response = await query;
    return response.map((e) => WorkerProfileModel.fromJson(e)).toList();
  }

  // Obtener todos los trabajadores
  Future<List<WorkerProfileModel>> getAllWorkers({int limit = 50}) async {
    final response = await _client
        .from('worker_profiles_v2')
        .select()
        .eq('is_available', true)
        .order('rating', ascending: false)
        .limit(limit);
    
    return response.map((e) => WorkerProfileModel.fromJson(e)).toList();
  }
}
