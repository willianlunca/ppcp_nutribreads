import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_list_ordens.dart';
import 'package:ppcp_nutribreads/componentes/card_ordem.dart';
import 'package:ppcp_nutribreads/functions/loop.dart';
import 'package:ppcp_nutribreads/screens/lista_produtos_ordens.dart';

class ListaOrdens extends StatefulWidget {
  const ListaOrdens({super.key});

  @override
  State<ListaOrdens> createState() => _ListaOrdensState();
}

class _ListaOrdensState extends State<ListaOrdens> {
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

  @override
  Widget build(BuildContext context) {
    final contador = DebugLoop.contador;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          Center(
            child: CabecalhoListOrdens(
              quantidade_pendente: 30,
              onTap: () {
                // Ação ao clicar no cabeçalho
                print('Atualizando lista de ordens de produção...');
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
                      prioridade:
                          '2', //contador.toString(), // para alternar. ( dubug )
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 8,
                      qtdProduzidas: 3, // ✅ se quiser mudar também
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
