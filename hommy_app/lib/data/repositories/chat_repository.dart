import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Obtener todas las conversaciones del usuario
  Future<List<Map<String, dynamic>>> getChats(String userId) async {
    final response = await _client
        .from('chats')
        .select('''
          *,
          chat_participants!inner(user_id),
          chat_messages(last_message: created_at, content)
        ''')
        .or('user1.eq.$userId,user2.eq.$userId')
        .order('updated_at', ascending: false);
    
    return response;
  }

  // Obtener mensajes de una conversación
  Stream<List<Map<String, dynamic>>> watchMessages(String chatId) {
    return _client
        .from('chat_messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: true)
        .watch();
  }

  // Obtener mensajes de una conversación (no-stream)
  Future<List<Map<String, dynamic>>> getMessages(String chatId, {int limit = 50}) async {
    final response = await _client
        .from('chat_messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: false)
        .limit(limit);
    
    return response.reversed.toList();
  }

  // Enviar mensaje
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String content,
    String? type,
  }) async {
    await _client.from('chat_messages').insert({
      'chat_id': chatId,
      'sender_id': senderId,
      'content': content,
      'type': type ?? 'text',
      'is_read': false,
    });

    // Actualizar el chat con última actividad
    await _client.from('chats').update({
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', chatId);
  }

  // Marcar mensajes como leídos
  Future<void> markAsRead(String chatId, String userId) async {
    await _client.from('chat_messages').update({
      'is_read': true,
    }).eq('chat_id', chatId).neq('sender_id', userId);
  }

  // Crear nueva conversación
  Future<String> createChat(String user1, String user2) async {
    // Verificar si ya existe
    final existing = await _client
        .from('chats')
        .select()
        .or('and(user1.eq.$user1,user2.eq.$user2),and(user1.eq.$user2,user2.eq.$user1)')
        .maybeSingle();

    if (existing != null) {
      return existing['id'];
    }

    final response = await _client.from('chats').insert({
      'user1': user1,
      'user2': user2,
    }).select().single();

    return response['id'];
  }

  // Obtener o crear chat con usuario
  Future<String> getOrCreateChat(String currentUserId, String otherUserId) async {
    return createChat(currentUserId, otherUserId);
  }
}
