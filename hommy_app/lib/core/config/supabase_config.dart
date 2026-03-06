import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Placeholders para desarrollo - reemplazar con valores reales
  static const String supabaseUrl = 'https://demo.supabase.co';
  static const String supabaseAnonKey = 'demo-key';

  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
    } catch (e) {
      debugPrint('Supabase init error (expected in demo mode): $e');
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
  
  // Modo demo sin Supabase real
  static bool get isDemoMode => true;
}
