import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                    Expanded(child: Text('Configuración', style: Theme.of(context).textTheme.titleLarge)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _SettingsSection(
                      title: 'Cuenta',
                      children: [
                        _SettingsTile(icon: Icons.person, title: 'Editar Perfil', onTap: () {}),
                        _SettingsTile(icon: Icons.lock, title: 'Cambiar Contraseña', onTap: () {}),
                        _SettingsTile(icon: Icons.email, title: 'Cambiar Email', onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _SettingsSection(
                      title: 'Notificaciones',
                      children: [
                        _SettingsSwitch(icon: Icons.notifications, title: 'Notificaciones Push', value: true),
                        _SettingsSwitch(icon: Icons.email_outlined, title: 'Notificaciones Email', value: true),
                        _SettingsSwitch(icon: Icons.chat, title: 'Notificaciones WhatsApp', value: false),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _SettingsSection(
                      title: 'Privacidad',
                      children: [
                        _SettingsTile(icon: Icons.privacy_tip, title: 'Política de Privacidad', onTap: () {}),
                        _SettingsTile(icon: Icons.description, title: 'Términos y Condiciones', onTap: () {}),
                        _SettingsTile(icon: Icons.delete_outline, title: 'Eliminar Cuenta', onTap: () {}, textColor: Colors.red),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _SettingsSection(
                      title: 'App',
                      children: [
                        _SettingsTile(icon: Icons.help, title: 'Ayuda y Soporte', onTap: () {}),
                        _SettingsTile(icon: Icons.info_outline, title: 'Versión', subtitle: '1.0.0', onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: 24),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title, style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? textColor;
  const _SettingsTile({required this.icon, required this.title, this.subtitle, required this.onTap, this.textColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.primary),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: subtitle == null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }
}

class _SettingsSwitch extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool value;
  const _SettingsSwitch({required this.icon, required this.title, required this.value});

  @override
  State<_SettingsSwitch> createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<_SettingsSwitch> {
  late bool _value;
  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, color: AppColors.primary),
      title: Text(widget.title),
      trailing: Switch(value: _value, onChanged: (v) => setState(() => _value = v), activeColor: AppColors.primary),
    );
  }
}
