import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

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
                    Expanded(child: Text('Mis Reservas', style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _BookingCard(title: 'Limpieza hogar', status: 'Pendiente', worker: 'María López', date: '2026-03-10', price: 50),
                    _BookingCard(title: 'Reparación eléctrica', status: 'Confirmada', worker: 'Carlos García', date: '2026-03-12', price: 75),
                    _BookingCard(title: 'Pintura sala', status: 'Completada', worker: 'Juan Pérez', date: '2026-03-05', price: 120),
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

class _BookingCard extends StatelessWidget {
  final String title, status, worker, date;
  final int price;
  const _BookingCard({required this.title, required this.status, required this.worker, required this.date, required this.price});

  Color get statusColor {
    if (status == 'Pendiente') return AppColors.warning;
    if (status == 'Confirmada') return AppColors.info;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(Icons.calendar_today, color: statusColor),
        ),
        title: Text(title),
        subtitle: Text('$worker • $date'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$$price', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            Text(status, style: TextStyle(fontSize: 10, color: statusColor)),
          ],
        ),
      ),
    );
  }
}
