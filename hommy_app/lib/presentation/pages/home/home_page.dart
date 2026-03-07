import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Row(children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.home_work, color: Colors.white, size: 20)),
                  const SizedBox(width: 12),
                  const Text('Hommy'),
                ]),
                actions: [
                  IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () => Navigator.pushNamed(context, '/notifications')),
                  IconButton(icon: const Icon(Icons.chat_outlined), onPressed: () => Navigator.pushNamed(context, '/chats')),
                  const SizedBox(width: 8),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildWelcomeCard(context),
                    const SizedBox(height: 24),
                    _SectionHeader(title: 'Servicios Populares', subtitle: 'Encuentra al mejor profesional', onSeeAll: () {}),
                    const SizedBox(height: 12),
                    SizedBox(height: 110, child: ListView(scrollDirection: Axis.horizontal, children: [
                      _CategoryCard(icon: Icons.cleaning_services, title: 'Limpieza', color: Colors.blue, onTap: () {}),
                      _CategoryCard(icon: Icons.electrical_services, title: 'Electricista', color: Colors.amber, onTap: () {}),
                      _CategoryCard(icon: Icons.plumbing, title: 'Plomería', color: Colors.teal, onTap: () {}),
                      _CategoryCard(icon: Icons.format_paint, title: 'Pintura', color: Colors.pink, onTap: () {}),
                      _CategoryCard(icon: Icons.yard, title: 'Jardinería', color: Colors.green, onTap: () {}),
                      _CategoryCard(icon: Icons.more_horiz, title: 'Otros', color: Colors.purple, onTap: () {}),
                    ])),
                    const SizedBox(height: 24),
                    _SectionHeader(title: 'Profesionales Destacados', subtitle: 'Los mejor valorados', onSeeAll: () => Navigator.pushNamed(context, '/workers')),
                    const SizedBox(height: 12),
                    _FeaturedWorkerCard(name: 'Carlos García', profession: 'Electricista', rating: 4.9, services: 156, hourlyRate: 25, onTap: () => Navigator.pushNamed(context, '/worker/1')),
                    _FeaturedWorkerCard(name: 'María López', profession: 'Limpiadora', rating: 4.8, services: 203, hourlyRate: 18, onTap: () => Navigator.pushNamed(context, '/worker/2')),
                    const SizedBox(height: 24),
                    _SectionHeader(title: 'Mis Servicios', subtitle: 'Gestiona tus servicios', onSeeAll: () => Navigator.pushNamed(context, '/my-services')),
                    const SizedBox(height: 12),
                    _QuickServiceCard(title: 'Limpieza del hogar', status: 'Pendiente', onTap: () => Navigator.pushNamed(context, '/service/1')),
                    _QuickServiceCard(title: 'Reparación eléctrica', status: 'En progreso', onTap: () => Navigator.pushNamed(context, '/service/2')),
                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))]),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
            NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Buscar'),
            NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Crear'),
            NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Chats'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, '/create-service'), child: const Icon(Icons.add)),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))]),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('¡Bienvenido! 👋', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('¿Qué necesitas hoy?', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withOpacity(0.9))),
          const SizedBox(height: 16),
          Row(children: [
            _QuickActionButton(icon: Icons.add_circle, label: 'Crear', onTap: () => Navigator.pushNamed(context, '/create-service')),
            const SizedBox(width: 12),
            _QuickActionButton(icon: Icons.search, label: 'Buscar', onTap: () => Navigator.pushNamed(context, '/workers')),
          ]),
        ])),
        Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.home_work, size: 40, color: Colors.white)),
      ]),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12), child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 8), Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))]))));
  }
}

class _SectionHeader extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback onSeeAll;
  const _SectionHeader({required this.title, required this.subtitle, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), Text(subtitle, style: Theme.of(context).textTheme.bodySmall)])),
      TextButton(onPressed: onSeeAll, child: const Text('Ver todo')),
    ]);
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  const _CategoryCard({required this.icon, required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(width: 90, margin: const EdgeInsets.only(right: 12), child: Material(color: Colors.white, borderRadius: BorderRadius.circular(16),
      child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16),
        child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 24)),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          ])))));
  }
}

class _FeaturedWorkerCard extends StatelessWidget {
  final String name, profession;
  final double rating;
  final int services, hourlyRate;
  final VoidCallback onTap;
  const _FeaturedWorkerCard({required this.name, required this.profession, required this.rating, required this.services, required this.hourlyRate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(margin: const EdgeInsets.only(bottom: 12), child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16),
      child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
        CircleAvatar(radius: 30, backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(name[0], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary))),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Expanded(child: Text(name, style: Theme.of(context).textTheme.titleMedium)), Icon(Icons.verified, color: AppColors.primary, size: 18)]),
          Text(profession, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Row(children: [Icon(Icons.star, color: Colors.amber[700], size: 16), const SizedBox(width: 4), Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 8), Text('($services servicios)', style: Theme.of(context).textTheme.bodySmall)]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('\$$hourlyRate', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)), const Text('/hora', style: TextStyle(fontSize: 12))]),
      ]))));
  }
}

class _QuickServiceCard extends StatelessWidget {
  final String title, status;
  final VoidCallback onTap;
  const _QuickServiceCard({required this.title, required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor = status == 'Pendiente' ? AppColors.warning : AppColors.info;
    return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(
      leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.work, color: statusColor)),
      title: Text(title),
      subtitle: Text(status, style: TextStyle(color: statusColor)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ));
  }
}
