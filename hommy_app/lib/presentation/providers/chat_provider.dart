import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/chat_repository.dart';

// Repository provider
final chatRepositoryProvider = Provider((ref) => ChatRepository());

// Chat list provider
final chatsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, userId) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getChats(userId);
});

// Messages provider
final messagesProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, chatId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.watchMessages(chatId);
});

// Chat notifier for sending messages
class ChatNotifier extends StateNotifier<AsyncValue<void>> {
  final ChatRepository _repository;
  final Ref _ref;

  ChatNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String content,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.sendMessage(
        chatId: chatId,
        senderId: senderId,
        content: content,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> getOrCreateChat(String currentUserId, String otherUserId) async {
    return _repository.getOrCreateChat(currentUserId, otherUserId);
  }
}

final chatNotifierProvider = StateNotifierProvider<ChatNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatNotifier(repository, ref);
});
