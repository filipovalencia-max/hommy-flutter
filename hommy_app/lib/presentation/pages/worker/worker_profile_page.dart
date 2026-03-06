import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class WorkerProfilePage extends StatefulWidget {
  const WorkerProfilePage({super.key});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  
  // Demo data
  String _profession = 'Electricista';
  int _experienceYears = 5;
  String _bio = 'Técnico electricista con más de 5 años de experiencia en instalaciones residenciales y comerciales.';
  double _hourlyRate = 25;
  bool _isAvailable = true;

  final List<Map<String, dynamic>> _categories = [
    {'id': '1', 'name': 'Electricidad', 'icon': Icons.electrical_services},
    {'id': '2', 'name': 'Plomería', 'icon': Icons.plumbing},
    {'id': '3', 'name': 'Limpieza', 'icon': Icons.cleaning_services},
    {'id': '4', 'name': 'Pintura', 'icon': Icons.format_paint},
    {'id': '5', 'name': 'Carpintería', 'icon': Icons.carpenter},
    {'id': '6', 'name': 'Jardinería', 'icon': Icons.yard},
  ];

  List<String> _selectedCategories = ['1', '3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: Text(
                        _isEditing ? 'Editar Perfil' : 'Mi Perfil Profesional',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (!_isEditing)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => setState(() => _isEditing = true),
                      ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _isEditing ? _buildEditForm() : _buildProfileView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileView() {
    return Column(
      children: [
        // Profile Header
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'Carlos García',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _profession,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatBadge(icon: Icons.star, value: '4.9', label: 'Rating'),
                  const SizedBox(width: 24),
                  _StatBadge(icon: Icons.work, value: '156', label: 'Servicios'),
                  const SizedBox(width: 24),
                  _StatBadge(icon: Icons.verified, value: '✓', label: 'Verificado'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // About
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('Sobre mí', style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 12),
                Text(_bio),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Details
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _DetailRow(icon: Icons.work_history, label: 'Experiencia', value: '$_experienceYears años'),
                const Divider(),
                _DetailRow(icon: Icons.attach_money, label: 'Tarifa', value: '\$$_hourlyRate/hora'),
                const Divider(),
                _DetailRow(
                  icon: Icons.schedule, 
                  label: 'Disponibilidad', 
                  value: _isAvailable ? 'Disponible' : 'No disponible',
                  valueColor: _isAvailable ? AppColors.success : AppColors.error,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Categories
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.category, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('Categorías', style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedCategories.map((catId) {
                    final cat = _categories.firstWhere((c) => c['id'] == catId);
                    return Chip(
                      avatar: Icon(cat['icon'], size: 18),
                      label: Text(cat['name']),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Información Profesional', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  
                  // Profession
                  DropdownButtonFormField<String>(
                    value: _profession,
                    decoration: const InputDecoration(
                      labelText: 'Profesión',
                      prefixIcon: Icon(Icons.work),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Electricista', child: Text('Electricista')),
                      DropdownMenuItem(value: 'Plomero', child: Text('Plomero')),
                      DropdownMenuItem(value: 'Pintor', child: Text('Pintor')),
                      DropdownMenuItem(value: 'Carpintero', child: Text('Carpintero')),
                      DropdownMenuItem(value: 'Limpiador', child: Text('Limpiador')),
                      DropdownMenuItem(value: 'Jardinero', child: Text('Jardinero')),
                    ],
                    onChanged: (v) => setState(() => _profession = v!),
                  ),
                  const SizedBox(height: 16),
                  
                  // Experience
                  Row(
                    children: [
                      const Text('Años de experiencia: '),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: _experienceYears > 0 
                            ? () => setState(() => _experienceYears--) 
                            : null,
                      ),
                      Text('$_experienceYears', style: const TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => _experienceYears++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Hourly Rate
                  TextFormField(
                    initialValue: _hourlyRate.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Tarifa por hora (\$)',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (v) => _hourlyRate = double.tryParse(v) ?? _hourlyRate,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sobre mí', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _bio,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Describe tu experiencia...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => _bio = v,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categorías', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategories.contains(cat['id']);
                      return FilterChip(
                        avatar: Icon(cat['icon'], size: 18),
                        label: Text(cat['name']),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedCategories.add(cat['id']);
                            } else {
                              _selectedCategories.remove(cat['id']);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Availability Switch
          Card(
            child: SwitchListTile(
              title: const Text('Disponible para trabajar'),
              subtitle: Text(_isAvailable ? 'Los clientes pueden contactarte' : 'No aparecerás en búsquedas'),
              value: _isAvailable,
              onChanged: (v) => setState(() => _isAvailable = v),
              activeColor: AppColors.primary,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _isEditing = false),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    setState(() => _isEditing = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perfil actualizado'), backgroundColor: Colors.green),
                    );
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatBadge({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon, 
    required this.label, 
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
