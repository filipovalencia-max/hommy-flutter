import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _whatsappNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(gradient: AppColors.backgroundGradient), child: 
        SafeArea(child: Column(children: [
          Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
            Expanded(child: Text('Configuración', style: Theme.of(context).textTheme.titleLarge)),
          ]))),
          Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
            _buildSection('Cuenta', [
              _SettingsTile(icon: Icons.person, title: 'Editar Perfil', onTap: () => context.push('/profile')),
              _SettingsTile(icon: Icons.lock, title: 'Cambiar Contraseña', onTap: () {}),
              _SettingsTile(icon: Icons.email, title: 'Cambiar Email', onTap: () {}),
              _SettingsTile(icon: Icons.phone, title: 'Verificar Teléfono', onTap: () {}, trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Text('Verificado', style: TextStyle(color: AppColors.success, fontSize: 11)))),
            ]),
            const SizedBox(height: 16),
            _buildSwitchSection('Notificaciones', [
              _SettingsSwitch(icon: Icons.notifications, title: 'Notificaciones Push', value: _pushNotifications, onChanged: (v) => setState(() => _pushNotifications = v)),
              _SettingsSwitch(icon: Icons.email_outlined, title: 'Notificaciones Email', value: _emailNotifications, onChanged: (v) => setState(() => _emailNotifications = v)),
              _SettingsSwitch(icon: Icons.chat, title: 'Notificaciones WhatsApp', value: _whatsappNotifications, onChanged: (v) => setState(() => _whatsappNotifications = v)),
            ]),
            const SizedBox(height: 16),
            _buildSection('Privacidad', [
              _SettingsTile(icon: Icons.privacy_tip, title: 'Política de Privacidad', onTap: () {}),
              _SettingsTile(icon: Icons.description, title: 'Términos y Condiciones', onTap: () {}),
              _SettingsTile(icon: Icons.delete_outline, title: 'Eliminar Cuenta', onTap: () {}, textColor: Colors.red, trailing: const Icon(Icons.chevron_right)),
            ]),
            const SizedBox(height: 16),
            _buildSection('App', [
              _SettingsTile(icon: Icons.help, title: 'Ayuda y Soporte', onTap: () {}),
              _SettingsTile(icon: Icons.info_outline, title: 'Versión', subtitle: '1.0.0'),
              _SettingsTile(icon: Icons.language, title: 'Idioma', subtitle: 'Español'),
            ]),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: OutlinedButton.icon(
              onPressed: () => context.go('/login'),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
            )),
          ])),
        ]))),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: Text(title, style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
      Card(child: Column(children: children)),
    ]);
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? textColor;
  final Widget? trailing;
  const _SettingsTile({required this.icon, required this.title, this.subtitle, required this.onTap, this.textColor, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.primary),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ?? (subtitle == null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SettingsSwitch({required this.icon, required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: Switch(value: value, onChanged: onChanged, activeColor: AppColors.primary),
    );
  }
}
