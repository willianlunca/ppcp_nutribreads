import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_list_ordens.dart';
import 'package:ppcp_nutribreads/componentes/card_ordem.dart';

class ListaOrdens extends StatelessWidget {
  const ListaOrdens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: CabecalhoListOrdens(quantidade_pendente: 30)),
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0147',
                      prioridade: '2',
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 8,
                      qtdProduzidas: 3,
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
