import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
                    Expanded(child: Text('Mensajes', style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _ChatTile(name: 'Carlos García', lastMsg: 'Perfecto, mañana a las 10', time: '09:30', unread: 2, online: true),
                    _ChatTile(name: 'María López', lastMsg: 'Gracias por el trabajo!', time: 'Ayer', unread: 0, online: false),
                    _ChatTile(name: 'Juan Pérez', lastMsg: 'Cuánto cobrarías?', time: 'Ayer', unread: 1, online: true),
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

class _ChatTile extends StatelessWidget {
  final String name, lastMsg, time;
  final int unread;
  final bool online;
  const _ChatTile({required this.name, required this.lastMsg, required this.time, required this.unread, required this.online});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(name[0], style: const TextStyle(color: AppColors.primary))),
          if (online) Positioned(right: 0, bottom: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.success, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
        ],
      ),
      title: Text(name, style: TextStyle(fontWeight: unread > 0 ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(lastMsg, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: TextStyle(fontSize: 12, color: unread > 0 ? AppColors.primary : AppColors.textLight)),
          if (unread > 0) Container(margin: const EdgeInsets.only(top: 4), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)), child: Text('$unread', style: const TextStyle(color: Colors.white, fontSize: 10))),
        ],
      ),
    );
  }
}
