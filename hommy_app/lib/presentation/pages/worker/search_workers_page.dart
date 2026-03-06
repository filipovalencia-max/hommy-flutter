import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SearchWorkersPage extends StatefulWidget {
  const SearchWorkersPage({super.key});

  @override
  State<SearchWorkersPage> createState() => _SearchWorkersPageState();
}

class _SearchWorkersPageState extends State<SearchWorkersPage> {
  final List<Map<String, dynamic>> _workers = [
    {'name': 'Carlos García', 'profession': 'Electricista', 'rating': 4.9, 'services': 156, 'price': 25},
    {'name': 'María López', 'profession': 'Limpiadora', 'rating': 4.8, 'services': 203, 'price': 18},
    {'name': 'Juan Pérez', 'profession': 'Pintor', 'rating': 4.7, 'services': 89, 'price': 22},
  ];

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
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _workers.length,
                  itemBuilder: (context, index) {
                    final w = _workers[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(w['name'][0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
                        title: Text(w['name']),
                        subtitle: Text('${w['profession']} • ⭐ ${w['rating']}'),
                        trailing: Text('\$${w['price']}/hr', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
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
