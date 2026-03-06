import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/service_model.dart';

class ServiceRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Obtener todos los servicios activos
  Future<List<ServiceModel>> getActiveServices({
    String? categoryId,
    String? location,
    int limit = 20,
  }) async {
    var query = _client
        .from('services_v2')
        .select()
        .eq('status', 'active')
        .order('created_at', ascending: false)
        .limit(limit);

    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }
    if (location != null) {
      query = query.eq('location', location);
    }

    final response = await query;
    return response.map((e) => ServiceModel.fromJson(e)).toList();
  }

  // Obtener servicios del usuario
  Future<List<ServiceModel>> getUserServices(String userId) async {
    final response = await _client
        .from('services_v2')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    
    return response.map((e) => ServiceModel.fromJson(e)).toList();
  }

  // Obtener servicio por ID
  Future<ServiceModel?> getServiceById(String serviceId) async {
    final response = await _client
        .from('services_v2')
        .select()
        .eq('id', serviceId)
        .maybeSingle();
    
    if (response == null) return null;
    return ServiceModel.fromJson(response);
  }

  // Crear servicio
  Future<ServiceModel> createService(ServiceModel service) async {
    final response = await _client
        .from('services_v2')
        .insert(service.toJson())
        .select()
        .single();
    
    return ServiceModel.fromJson(response);
  }

  // Actualizar servicio
  Future<void> updateService(String serviceId, Map<String, dynamic> data) async {
    await _client
        .from('services_v2')
        .update(data)
        .eq('id', serviceId);
  }

  // Eliminar servicio (soft delete)
  Future<void> deleteService(String serviceId) async {
    await _client
        .from('services_v2')
        .update({'status': 'deleted'})
        .eq('id', serviceId);
  }

  // Contratar trabajador
  Future<void> hireWorker(String serviceId, String workerId, double amount) async {
    await _client
        .from('services_v2')
        .update({
          'status': 'hired',
          'worker_id': workerId,
          'escrow_amount': amount,
        })
        .eq('id', serviceId);
  }

  // Completar servicio
  Future<void> completeService(String serviceId, String pin) async {
    await _client
        .from('services_v2')
        .update({
          'status': 'completed',
          'completion_pin': pin,
          'pin_generated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', serviceId);
  }

  // Obtener categorías
  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await _client
        .from('categories_v2')
        .select()
        .eq('is_active', true)
        .order('name');
    
    return response;
  }
}
