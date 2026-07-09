import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:billhard_app/componentes/ppcp_cabecalho_list_ordens.dart';
import 'package:billhard_app/componentes/ppcp_card_ordem.dart';
import 'package:billhard_app/functions/loop.dart';
import 'package:billhard_app/screens/ppcp_lista_produtos_ordens.dart';
import 'package:billhard_app/services/api.dart';

class ListaOrdens extends StatefulWidget {
  const ListaOrdens({super.key});

  @override
  State<ListaOrdens> createState() => _ListaOrdensState();
}

class _ListaOrdensState extends State<ListaOrdens> {
  // Ajuste aqui se quiser
  static const String _token = 'nb_3f8a9c2e5d1b4a0c9f7e6d3c2b1a0f9e';

  static const String _host = 'http://localhost';
  static const String _port = '8080';
  static const String _dbPrincipal = 'wclunca_principal';
  static const String _dbPublico = 'wclunca_publico';
  static const String _table = 'cad_lote';

  @override
  void initState() {
    super.initState();

    DebugLoop.onTick = () {
      if (mounted) setState(() {});
    };

    DebugLoop.iniciar();
  }

  @override
  void dispose() {
    DebugLoop.parar();
    super.dispose();
  }

  /// Busca dados na sua API.
  /// - Se NÃO passar whereCol/whereVal -> traz tudo.
  /// - Se NÃO passar limit/offset -> não manda limit/offset.
  Future<List<dynamic>> selectMysql({
    required String host, // ex: 'http://localhost'
    required String port, // ex: '8080'
    required String db,
    required String table,

    String? whereCol,
    String? whereVal,
    int? limit,
    int? offset,
  }) async {
    // Normaliza host (sem barra no final)
    final baseHost = host.endsWith('/')
        ? host.substring(0, host.length - 1)
        : host;

    final baseUrl = '$baseHost:$port/data';

    // Query params base
    final params = <String, String>{'db': db, 'table': table};

    // Filtro só se whereCol e whereVal vierem preenchidos
    final hasWhereCol = (whereCol ?? '').trim().isNotEmpty;
    final hasWhereVal = (whereVal ?? '').trim().isNotEmpty;

    if (hasWhereCol && hasWhereVal) {
      params['where_col'] = whereCol!.trim();
      params['where_op'] = 'eq';
      params['where_val'] = whereVal!.trim();
    }

    // Paginacao opcional
    if (limit != null) params['limit'] = limit.toString();
    if (offset != null) params['offset'] = offset.toString();

    final uri = Uri.parse(baseUrl).replace(queryParameters: params);

    debugPrint('GET: $uri');

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      // segurança: se não vier 'data', retorna lista vazia
      final data = json['data'];
      if (data is List) return data;

      return <dynamic>[];
    }

    throw Exception('Erro API: ${response.statusCode} - ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Center(
            child: CabecalhoListOrdens(
              quantidade_pendente: 30,
              onTap: () async {
                debugPrint('Atualizando lista de ordens de produção...');

                // ✅ EXEMPLOS (use só 1 por vez)

                // 1) Buscar tudo (sem filtro, sem limit, sem offset):
                //final dados = await selectMysql(
                //host: _host,
                //port: _port,
                //db: _dbPrincipal,
                //table: _table,
                //);

                // 2) Buscar por CODIGO=14:
                // final dados = await selectMysql(
                //   host: _host,
                //   port: _port,
                //   db: _dbPrincipal,
                //   table: _table,
                //   whereCol: 'CODIGO',
                //   whereVal: '14',
                // );

                // 3) Paginação (limit/offset) sem filtro:
                // final dados = await selectMysql(
                //   host: _host,
                //   port: _port,
                //   db: _dbPrincipal,
                //   table: _table,
                //   limit: 20,
                //   offset: 0,
                // );

                // 4) Filtro + paginação:
                final dados = await selectMysql(
                  host: _host,
                  port: _port,
                  db: _dbPrincipal,
                  table: 'cad_orca',
                  limit: 2,
                  offset: 1,
                );

                debugPrint(const JsonEncoder.withIndent('  ').convert(dados));

                //inserirOrdem();
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0147',
                      prioridade: '1', // ou contador.toString()
                      linhaProducao: 'Linha 01',
                      data: '02/02/2026',
                      qtdItens: 19,
                      qtdProduzidas: 23,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListaPoroducao(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
