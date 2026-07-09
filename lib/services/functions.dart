import 'package:billhard_app/services/api.dart';

List<Map<String, dynamic>> lista = [];
bool carregando = false;

Future<List<Map<String, dynamic>>> carregarColaboradores() async {
  final resultado = await buscarColaboradores();
  return List<Map<String, dynamic>>.from(resultado);
}
