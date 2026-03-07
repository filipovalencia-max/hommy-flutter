import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  final List<Map<String, dynamic>> _transactions = [
    {'type': 'in', 'title': 'Depósito recibido', 'subtitle': 'Servicio de Limpieza completado', 'amount': 50, 'date': '2026-03-05', 'status': 'completed'},
    {'type': 'out', 'title': 'Pago a trabajador', 'subtitle': 'Servicio de Reparación eléctrica', 'amount': -75, 'date': '2026-03-03', 'status': 'completed'},
    {'type': 'in', 'title': 'Depósito recibido', 'subtitle': 'Servicio de Pintura', 'amount': 120, 'date': '2026-02-28', 'status': 'completed'},
    {'type': 'escrow', 'title': 'En escrow', 'subtitle': 'Limpieza del hogar', 'amount': 50, 'date': '2026-03-06', 'status': 'pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(gradient: AppColors.backgroundGradient), child: 
        SafeArea(child: Column(children: [
          Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
            Expanded(child: Text('Pagos', style: Theme.of(context).textTheme.titleLarge)),
          ])),
          Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
            _buildBalanceCard(context),
            const SizedBox(height: 24),
            _buildEscrowSection(context),
            const SizedBox(height: 24),
            _buildTransactionsSection(context),
          ])),
        ]))),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))]),
      child: Column(children: [
        const Text('Saldo Disponible', style: TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        const Text('\$125.50', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _QuickAction(icon: Icons.add, label: 'Añadir'),
          _QuickAction(icon: Icons.send, label: 'Enviar'),
          _QuickAction(icon: Icons.receipt, label: 'Historial'),
          _QuickAction(icon: Icons.credit_card, label: 'Métodos'),
        ]),
      ]));
  }

  Widget _buildEscrowSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('En Escrow', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.shield, color: AppColors.warning)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Limpieza del hogar', style: TextStyle(fontWeight: FontWeight.w600)),
          Text('En progreso - Se liberará al completar', style: TextStyle(color: AppColors.warning, fontSize: 12)),
        ])),
        const Text('\$50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ]))),
    ]);
  }

  Widget _buildTransactionsSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Transacciones Recientes', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 12),
      ..._transactions.map((t) => _TransactionTile(transaction: t)),
    ]);
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.white)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
    ]);
  }
}

class _TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;
  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isPositive = transaction['amount'] > 0;
    final color = transaction['type'] == 'escrow' ? AppColors.warning : (isPositive ? AppColors.success : AppColors.error);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(
            transaction['type'] == 'in' ? Icons.arrow_downward : (transaction['type'] == transaction['type'] == 'escrow' ? Icons.shield : Icons.arrow_upward),
            color: color,
            size: 20,
          ),
        ),
        title: Text(transaction['title']),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(transaction['subtitle'], style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text(transaction['date'], style: TextStyle(fontSize: 11, color: AppColors.textLight)),
        ]),
        trailing: Text(
          transaction['type'] == 'escrow' ? '\$${transaction['amount']}' : (isPositive ? '+\$${transaction['amount']}' : '-\$${transaction['amount'].abs()}'),
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
