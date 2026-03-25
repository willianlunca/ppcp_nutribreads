import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class Permissoes {
  static Future<List<Map<String, dynamic>>> temPermissao(
    String permissao,
  ) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) return [];

    if (kDebugMode) {
      debugPrint('UUID: ${user.id}');
    }

    try {
      final response = await supabase
          .from('permissoes_app')
          .select(permissao)
          .eq('user', user.id);

      if (kDebugMode) {
        debugPrint('Resposta completa: $response');
      }

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Erro ao consultar permissões: $e');
      }
      return [];
    }
  }
}
