import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class MyServicesPage extends StatefulWidget {
  const MyServicesPage({super.key});

  @override
  State<MyServicesPage> createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _services = [
    {'id': '1', 'title': 'Limpieza del hogar', 'status': 'active', 'date': '2026-03-05', 'applications': 3, 'budget': 50},
    {'id': '2', 'title': 'Reparación eléctrica', 'status': 'hired', 'date': '2026-03-03', 'worker': 'Carlos García', 'budget': 75},
    {'id': '3', 'title': 'Pintura sala', 'status': 'completed', 'date': '2026-02-28', 'worker': 'Juan Pérez', 'budget': 120},
    {'id': '4', 'title': 'Instalación aire', 'status': 'cancelled', 'date': '2026-02-20', 'budget': 200},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(gradient: AppColors.backgroundGradient), child: 
        SafeArea(child: Column(children: [
          Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
            Expanded(child: Text('Mis Servicios', style: Theme.of(context).textTheme.titleLarge)),
            IconButton(icon: const Icon(Icons.add), onPressed: () => context.push('/create-service')),
          ])),
          Container(margin: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), 
            child: TabBar(controller: _tabController, labelColor: Colors.white, unselectedLabelColor: AppColors.textSecondary, indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)), dividerColor: Colors.transparent,
              tabs: const [Tab(text: 'Todos'), Tab(text: 'Activos'), Tab(text: 'En Progreso'), Tab(text: 'Completos')])),
          const SizedBox(height: 16),
          Expanded(child: TabBarView(controller: _tabController, children: [
            _buildList(_services),
            _buildList(_services.where((s) => s['status'] == 'active').toList()),
            _buildList(_services.where((s) => s['status'] == 'hired').toList()),
            _buildList(_services.where((s) => s['status'] == 'completed').toList()),
          ])),
        ])),
      floatingActionButton: FloatingActionButton(onPressed: () => context.push('/create-service'), child: const Icon(Icons.add)),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> services) {
    if (services.isEmpty) {
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.work_off, size: 64, color: AppColors.textLight),
        const SizedBox(height: 16),
        Text('No hay servicios', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary)),
      ]));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: services.length,
      itemBuilder: (context, index) => _ServiceCard(service: services[index]),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;
  const _ServiceCard({required this.service});

  Color get statusColor {
    switch (service['status']) {
      case 'active': return AppColors.success;
      case 'hired': return AppColors.info;
      case 'in_progress': return AppColors.warning;
      case 'completed': return AppColors.primary;
      case 'cancelled': return AppColors.error;
      default: return AppColors.textSecondary;
    }
  }

  String get statusText {
    switch (service['status']) {
      case 'active': return 'Activo';
      case 'hired': return 'Contratado';
      case 'in_progress': return 'En Progreso';
      case 'completed': return 'Completado';
      case 'cancelled': return 'Cancelado';
      default: return service['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/service/${service['id']}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(service['title'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.w600, fontSize: 12))),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(service['date'], style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            if (service['worker'] != null) ...[
              const SizedBox(width: 16),
              Icon(Icons.person, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(service['worker'], style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
            const Spacer(),
            Text('\$${service['budget']}', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
          ]),
          if (service['status'] == 'active' && service['applications'] != null) ...[
            const SizedBox(height: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text('${service['applications']} postulaciones', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600))),
          ],
        ])),
      ),
    );
  }
}
