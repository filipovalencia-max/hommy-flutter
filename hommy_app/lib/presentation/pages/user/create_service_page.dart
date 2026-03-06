import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/service_model.dart';

class CreateServicePage extends StatefulWidget {
  const CreateServicePage({super.key});

  @override
  State<CreateServicePage> createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String? _selectedCategory;
  bool _isLoading = false;

  final List<Map<String, String>> _categories = [
    {'id': '1', 'name': 'Limpieza'},
    {'id': '2', 'name': 'Electricidad'},
    {'id': '3', 'name': 'Plomería'},
    {'id': '4', 'name': 'Pintura'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _createService() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Servicio creado!'), backgroundColor: Colors.green),
        );
        context.go('/home');
      }
    });
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
                    Expanded(child: Text('Crear Servicio', style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(labelText: 'Título', prefixIcon: Icon(Icons.work)),
                          validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(labelText: 'Categoría', prefixIcon: Icon(Icons.category)),
                          items: _categories.map((c) => DropdownMenuItem(value: c['id'], child: Text(c['name']!))).toList(),
                          onChanged: (v) => setState(() => _selectedCategory = v),
                          validator: (v) => v == null ? 'Selecciona' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(labelText: 'Ubicación', prefixIcon: Icon(Icons.location_on)),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(labelText: 'Descripción', alignLabelWithHint: true),
                          validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: _isLoading ? null : _createService,
                          child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Crear Servicio'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
