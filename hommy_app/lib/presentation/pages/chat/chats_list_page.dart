import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

// Demo data for chat list
class _ChatDemoData {
  static final List<Map<String, dynamic>> chats = [
    {
      'id': '1',
      'name': 'Carlos García',
      'avatar': 'C',
      'lastMessage': 'Perfecto, mañana a las 10',
      'time': '09:30',
      'unread': 2,
      'online': true,
    },
    {
      'id': '2',
      'name': 'María López',
      'avatar': 'M',
      'lastMessage': 'Gracias por el trabajo!',
      'time': 'Ayer',
      'unread': 0,
      'online': false,
    },
    {
      'id': '3',
      'name': 'Juan Pérez',
      'avatar': 'J',
      'lastMessage': 'Cuánto cobrarías por...?',
      'time': 'Ayer',
      'unread': 1,
      'online': true,
    },
    {
      'id': '4',
      'name': 'Ana Martínez',
      'avatar': 'A',
      'lastMessage': 'El servicio está completado',
      'time': 'Lunes',
      'unread': 0,
      'online': false,
    },
  ];
}

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: Text(
                        'Mensajes',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              // Chat List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _ChatDemoData.chats.length,
                  itemBuilder: (context, index) {
                    final chat = _ChatDemoData.chats[index];
                    return _ChatListItem(
                      name: chat['name'],
                      avatar: chat['avatar'],
                      lastMessage: chat['lastMessage'],
                      time: chat['time'],
                      unread: chat['unread'],
                      online: chat['online'],
                      onTap: () => context.push('/chat/${chat['id']}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final String name;
  final String avatar;
  final String lastMessage;
  final String time;
  final int unread;
  final bool online;
  final VoidCallback onTap;

  const _ChatListItem({
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.online,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      avatar,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  if (online)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: unread > 0 ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                        Text(
                          time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: unread > 0 ? AppColors.primary : AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: unread > 0 ? AppColors.textPrimary : AppColors.textSecondary,
                              fontWeight: unread > 0 ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (unread > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              unread.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
