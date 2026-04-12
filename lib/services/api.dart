import 'package:supabase_flutter/supabase_flutter.dart';

// Verificar se o usuário está logado
void debugUsuarioLogado() {
  final user = Supabase.instance.client.auth.currentUser;
  print('user logado: ${user?.id ?? "null"}');
}

// Encerrar sessão
Future<void> encerrarSessao() async {
  final supabase = Supabase.instance.client;

  try {
    await supabase.auth.signOut();
    print('Sessão encerrada com sucesso!');
  } catch (e) {
    print('Erro ao encerrar sessão: $e');
  }
}

// Inserir ordem
Future<List<Map<String, dynamic>>> inserirOrdem() async {
  try {
    final data = await Supabase.instance.client.from('lista_ordens').insert({
      'descricao_ordem': 'OP-2026-0147',
      'prioridade': '1',
      'linha_producao': 'Linha 02',
      'data': '13/02/2026',
      'qtd_itens': 8,
      'qtd_produzidas': 3,
    }).select();

    print(data);

    return List<Map<String, dynamic>>.from(data);
  } catch (e) {
    print('Erro ao inserir ordem: $e');
    rethrow;
  }
}

// Inserir colaborador
Future<void> inserirColaborador({
  required String nome,
  required String cpf, // <-- String agora
  required DateTime aniversario,
}) async {
  final supabase = Supabase.instance.client;

  await supabase.from('colaboradores').insert({
    'nome': nome,
    'cpf': cpf,
    'aniversario': aniversario.toIso8601String().split('T').first,
  });

  print('Inserido OK');
}

// Buscar colaboradores
Future<List<Map<String, dynamic>>> buscarColaboradores() async {
  final supabase = Supabase.instance.client;

  final data = await supabase
      .from('colaboradores')
      .select('*')
      .order('id', ascending: false); // se tiver coluna id

  final lista = List<Map<String, dynamic>>.from(data);
  print('Total encontrados: ${lista.length}');
  return lista;
}

class PermissoesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Busca todas as permissões do usuário logado
  Future<List<Map<String, dynamic>>> buscarPermissoes() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não está logado');
    }

    final response = await _supabase
        .from('permissoes_modulos')
        .select()
        .eq('user', user.id); // ajuste se o nome da coluna for diferente

    return List<Map<String, dynamic>>.from(response);
  }
}
