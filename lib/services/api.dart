import 'package:supabase_flutter/supabase_flutter.dart';


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

