import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SearchWorkersPage extends StatelessWidget {
  const SearchWorkersPage({super.key});

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
                    Expanded(child: Text('Buscar Profesionales', style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Buscar...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _WorkerCard(name: 'Carlos García', profession: 'Electricista', rating: 4.9, services: 156, price: 25),
                    _WorkerCard(name: 'María López', profession: 'Limpiadora', rating: 4.8, services: 203, price: 18),
                    _WorkerCard(name: 'Juan Pérez', profession: 'Pintor', rating: 4.7, services: 89, price: 22),
                    _WorkerCard(name: 'Ana Martínez', profession: 'Plomera', rating: 4.9, services: 134, price: 30),
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

class _WorkerCard extends StatelessWidget {
  final String name, profession;
  final double rating;
  final int services, price;
  const _WorkerCard({required this.name, required this.profession, required this.rating, required this.services, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(name[0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('$profession • ⭐ $rating ($services srv)'),
        trailing: Text('\$$price/hr', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
