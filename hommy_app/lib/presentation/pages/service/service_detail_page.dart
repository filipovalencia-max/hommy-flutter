import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class ServiceDetailPage extends StatefulWidget {
  final String serviceId;
  const ServiceDetailPage({super.key, required this.serviceId});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final Map<String, dynamic> _service = {
    'id': '1', 'title': 'Limpieza del hogar', 'description': 'Se necesita limpiador profesional para limpieza general de apartamento de 80m2. Incluye sala, cocina, 2 habitaciones y 2 baños. Se requiere experiencia previa.',
    'category': 'Limpieza', 'location': 'Calle Mayor 123, Madrid', 'budget': 50, 'date': '2026-03-15',
    'status': 'active',
    'user': {'name': 'Pedro García', 'rating': 4.8, 'phone': '+34 612 345 678', 'verified': true},
    'applications': [
      {'id': '1', 'worker': 'María López', 'rating': 4.9, 'experience': '5 años', 'offer': 45, 'message': 'Tengo experiencia en limpieza de hogares'},
      {'id': '2', 'worker': 'Ana Martínez', 'rating': 4.7, 'experience': '3 años', 'offer': 40, 'message': 'Disponible inmediatamente'},
      {'id': '3', 'worker': 'Carlos Ruiz', 'rating': 4.8, 'experience': '7 años', 'offer': 55, 'message': 'Servicio premium garantizado'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(gradient: AppColors.backgroundGradient), child: 
        SafeArea(child: Column(children: [
          _buildHeader(context),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildInfoCard(context),
            const SizedBox(height: 16),
            _buildDescriptionCard(context),
            const SizedBox(height: 16),
            _buildClientCard(context),
            const SizedBox(height: 16),
            if (_service['status'] == 'active') _buildApplicationsCard(context),
            const SizedBox(height: 100),
          ]))),
          _buildBottomBar(context),
        ])),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(padding: const EdgeInsets.all(16), child: Row(children: [
      IconButton(icon: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]), child: const Icon(Icons.arrow_back, size: 20)), onPressed: () => context.pop()),
      const Spacer(),
      IconButton(icon: const Icon(Icons.share), onPressed: () {}),
      IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
    ]));
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: const Text('Activo', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 12))),
        const Spacer(),
        Icon(Icons.favorite_border, color: AppColors.textSecondary),
      ]),
      const SizedBox(height: 12),
      Text(_service['title'], style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Row(children: [
        Icon(Icons.category, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(_service['category'], style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(width: 16),
        Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Expanded(child: Text(_service['location'], style: TextStyle(color: AppColors.textSecondary), overflow: TextOverflow.ellipsis)),
      ]),
    ])));
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Descripción', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      Text(_service['description'], style: TextStyle(color: AppColors.textSecondary, height: 1.5)),
      const SizedBox(height: 16),
      Row(children: [
        Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text('Fecha: ${_service['date']}', style: const TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        Icon(Icons.attach_money, size: 20, color: AppColors.primary),
        Text('Presupuesto: \$${_service['budget']}', style: const TextStyle(fontWeight: FontWeight.w600)),
      ]),
    ])));
  }

  Widget _buildClientCard(BuildContext context) {
    final user = _service['user'];
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Cliente', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      Row(children: [
        CircleAvatar(radius: 24, backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(user['name'][0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(user['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
            if (user['verified']) ...[const SizedBox(width: 4), Icon(Icons.verified, color: AppColors.primary, size: 16)],
          ]),
          Row(children: [Icon(Icons.star, size: 14, color: Colors.amber[700]), const SizedBox(width: 4), Text('${user['rating']}')]),
        ])),
        IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () => context.push('/chat/1')),
        IconButton(icon: const Icon(Icons.phone), onPressed: () {}),
      ]),
    ])));
  }

  Widget _buildApplicationsCard(BuildContext context) {
    final apps = _service['applications'] as List;
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('Postulaciones', style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Text('${apps.length}', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
      ]),
      const SizedBox(height: 12),
      ...apps.map((app) => _ApplicationTile(app: app)),
    ])));
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))]),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text('Presupuesto', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          Text('\$${_service['budget']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ])),
        Expanded(child: FilledButton(onPressed: () {}, child: const Text('Contactar Cliente'))),
      ]),
    );
  }
}

class _ApplicationTile extends StatelessWidget {
  final Map<String, dynamic> app;
  const _ApplicationTile({required this.app});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        CircleAvatar(radius: 20, backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(app['worker'][0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(app['worker'], style: const TextStyle(fontWeight: FontWeight.w600)),
          Text('${app['experience']} • ⭐ ${app['rating']}', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('\$${app['offer']}', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          SizedBox(height: 32, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12)), child: const Text('Ver', style: TextStyle(fontSize: 12)))),
        ]),
      ]),
    );
  }
}
