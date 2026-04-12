import 'package:supabase_flutter/supabase_flutter.dart';




class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// LOGIN COM EMAIL E SENHA
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// LOGOUT
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// USUÁRIO LOGADO ATUAL
  User? get currentUser {
    return _supabase.auth.currentUser;
  }

  /// VERIFICA SE ESTÁ LOGADO
  bool get isLoggedIn {
    return currentUser != null;
  }
}

