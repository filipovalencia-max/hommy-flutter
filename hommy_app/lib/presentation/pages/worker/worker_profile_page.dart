import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class WorkerProfilePage extends StatefulWidget {
  final String workerId;
  const WorkerProfilePage({super.key, required this.workerId});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  final Map<String, dynamic> _worker = {
    'id': '1', 'name': 'Carlos García', 'profession': 'Electricista', 'bio': 'Técnico electricista con más de 5 años de experiencia en instalaciones residenciales y comerciales. Certificado y con garantía en todos los trabajos.',
    'experience': 5, 'rating': 4.9, 'services': 156, 'verified': true, 'hourlyRate': 25, 'location': 'Madrid',
    'categories': ['Electricidad', 'Instalaciones', 'Reparaciones'],
    'certifications': ['Certificado Profesional', 'ISO 9001'],
    'portfolio': [
      {'title': 'Instalación eléctrica vivienda', 'image': 'https://picsum.photos/200/150?random=1'},
      {'title': 'Reparación cuadro eléctrico', 'image': 'https://picsum.photos/200/150?random=2'},
      {'title': 'Instalación domótica', 'image': 'https://picsum.photos/200/150?random=3'},
    ],
    'reviews': [
      {'user': 'María L.', 'rating': 5, 'comment': 'Excelente trabajo, muy profesional y puntuales.', 'date': '2026-02-15'},
      {'user': 'Juan P.', 'rating': 5, 'comment': 'Gran servicio, recomendado.', 'date': '2026-02-10'},
      {'user': 'Ana M.', 'rating': 4, 'comment': 'Buen trabajo, puntuales.', 'date': '2026-01-28'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(gradient: AppColors.backgroundGradient), child: 
        SafeArea(child: Column(children: [
          _buildHeader(context),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
            _buildProfileCard(context),
            const SizedBox(height: 16),
            _buildAboutCard(context),
            const SizedBox(height: 16),
            _buildCategoriesCard(context),
            const SizedBox(height: 16),
            _buildPortfolioCard(context),
            const SizedBox(height: 16),
            _buildReviewsCard(context),
            const SizedBox(height: 100),
          ]))),
          _buildBottomBar(context),
        ]))),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(padding: const EdgeInsets.all(16), child: Row(children: [
      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      const Spacer(),
      IconButton(icon: const Icon(Icons.share), onPressed: () {}),
    ]));
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(24)), child: Column(children: [
      CircleAvatar(radius: 50, backgroundColor: Colors.white.withOpacity(0.2), child: Text(_worker['name'][0], style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold))),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(_worker['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        if (_worker['verified']) ...[const SizedBox(width: 8), Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.verified, color: Colors.white, size: 16))],
      ]),
      Text(_worker['profession'], style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9))),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _StatItem(icon: Icons.star, value: '${_worker['rating']}', label: 'Rating'),
        _StatItem(icon: Icons.work, value: '${_worker['services']}', label: 'Servicios'),
        _StatItem(icon: Icons.access_time, value: '${_worker['experience']} años', label: 'Experiencia'),
      ]),
    ]));
  }

  Widget _buildAboutCard(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Sobre mí', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      Text(_worker['bio'], style: TextStyle(color: AppColors.textSecondary, height: 1.5)),
      const SizedBox(height: 16),
      Row(children: [
        Icon(Icons.location_on, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(_worker['location'], style: const TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        Text('\$${_worker['hourlyRate']}/hr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
      ]),
    ])));
  }

  Widget _buildCategoriesCard(BuildContext context) {
    final cats = _worker['categories'] as List;
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Categorías', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: cats.map((c) => Chip(label: Text(c))).toList()),
    ])));
  }

  Widget _buildPortfolioCard(BuildContext context) {
    final portfolio = _worker['portfolio'] as List;
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Trabajos Realizados', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      SizedBox(height: 120, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: portfolio.length, itemBuilder: (ctx, i) => Container(
        width: 160, margin: const EdgeInsets.only(right: 12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.background),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 80, decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), color: AppColors.primary.withOpacity(0.2)),
            child: Center(child: Icon(Icons.image, color: AppColors.primary, size: 32))),
          Padding(padding: const EdgeInsets.all(8), child: Text(portfolio[i]['title'], style: const TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),
        ]),
      ))),
    ])));
  }

  Widget _buildReviewsCard(BuildContext context) {
    final reviews = _worker['reviews'] as List;
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('Reseñas', style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        Row(children: [Icon(Icons.star, color: Colors.amber[700], size: 16), const SizedBox(width: 4), Text('${_worker['rating']} (${reviews.length})', style: TextStyle(fontWeight: FontWeight.w600))]),
      ]),
      const SizedBox(height: 12),
      ...reviews.map((r) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 16, backgroundColor: AppColors.primary.withOpacity(0.1), child: Text(r['user'][0], style: const TextStyle(fontSize: 12, color: AppColors.primary))),
            const SizedBox(width: 8),
            Expanded(child: Text(r['user'], style: const TextStyle(fontWeight: FontWeight.w600))),
            Row(children: List.generate(5, (i) => Icon(i < r['rating'] ? Icons.star : Icons.star_border, color: Colors.amber[700], size: 14))),
          ]),
          const SizedBox(height: 8),
          Text(r['comment'], style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 4),
          Text(r['date'], style: TextStyle(color: AppColors.textLight, fontSize: 11)),
        ]))),
    ])));
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))]),
      child: Row(children: [
        Expanded(child: OutlinedButton.icon(onPressed: () => context.push('/chat/${_worker['id']}'), icon: const Icon(Icons.chat_bubble_outline), label: const Text('Chat'))),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: FilledButton(onPressed: () {}, child: const Text('Contratar \$${_worker['hourlyRate']}/hr'))),
      ]),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value, label;
  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon, color: Colors.white, size: 24),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
    ]);
  }
}
