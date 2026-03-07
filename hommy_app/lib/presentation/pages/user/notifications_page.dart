import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  final List<Map<String, dynamic>> _notifications = [
    {'type': 'booking', 'title': 'Nueva reserva confirmada', 'message': 'Tu reserva para "Limpieza del hogar" ha sido confirmada', 'time': '2 horas', 'read': false},
    {'type': 'chat', 'title': 'Nuevo mensaje', 'message': 'Carlos García te envió un mensaje', 'time': '5 horas', 'read': false},
    {'type': 'service', 'title': 'Nueva postulación', 'message': '3 trabajadores se postularon a tu servicio', 'time': '1 día', 'read': true},
    {'type': 'system', 'title': 'Bienvenido a Hommy', 'message': 'Gracias por unirte a nuestra plataforma', 'time': '3 días', 'read': true},
  ];

  IconData _getIcon(String type) {
    switch (type) {
      case 'booking': return Icons.calendar_today;
      case 'chat': return Icons.chat_bubble;
      case 'service': return Icons.work;
      default: return Icons.notifications;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'booking': return AppColors.info;
      case 'chat': return AppColors.success;
      case 'service': return AppColors.warning;
      default: return AppColors.primary;
    }
  }

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
                    Expanded(child: Text('Notificaciones', style: Theme.of(context).textTheme.titleLarge)),
                    TextButton(onPressed: () {}, child: const Text('Marcar todo leído')),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final n = _notifications[index];
                    final color = _getColor(n['type']);
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      color: n['read'] == false ? AppColors.primary.withOpacity(0.05) : null,
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                          child: Icon(_getIcon(n['type']), color: color, size: 20),
                        ),
                        title: Text(n['title'], style: TextStyle(fontWeight: n['read'] == false ? FontWeight.bold : FontWeight.normal)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n['message'], maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text(n['time'], style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                          ],
                        ),
                        trailing: n['read'] == false ? Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)) : null,
                        isThreeLine: true,
                      ),
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
