import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                    Expanded(child: Text('Mi Perfil', style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(radius: 50, backgroundColor: AppColors.primary.withOpacity(0.1), child: const Icon(Icons.person, size: 50, color: AppColors.primary)),
                      const SizedBox(height: 16),
                      const Text('Carlos García', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const Text('carlos@email.com', style: TextStyle(color: AppColors.textSecondary)),
                      const SizedBox(height: 24),
                      Card(
                        child: Column(
                          children: [
                            ListTile(leading: const Icon(Icons.person), title: const Text('Editar Perfil'), trailing: const Icon(Icons.chevron_right)),
                            const Divider(height: 1),
                            ListTile(leading: const Icon(Icons.notifications), title: const Text('Notificaciones'), trailing: const Icon(Icons.chevron_right)),
                            const Divider(height: 1),
                            ListTile(leading: const Icon(Icons.security), title: const Text('Privacidad'), trailing: const Icon(Icons.chevron_right)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => context.go('/login'),
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
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
