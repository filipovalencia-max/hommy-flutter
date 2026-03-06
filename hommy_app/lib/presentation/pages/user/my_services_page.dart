import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class MyServicesPage extends StatelessWidget {
  const MyServicesPage({super.key});

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
                    Expanded(child: Text('Mis Servicios', style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _ServiceCard(title: 'Limpieza hogar', status: 'Activo', date: '2026-03-05'),
                    _ServiceCard(title: 'Reparación eléctrica', status: 'En progreso', date: '2026-03-03'),
                    _ServiceCard(title: 'Pintura sala', status: 'Completado', date: '2026-02-28'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => context.push('/create-service'), child: const Icon(Icons.add)),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title, status, date;
  const _ServiceCard({required this.title, required this.status, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.work, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: Text('$status • $date'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
