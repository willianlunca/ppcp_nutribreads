import 'package:flutter/material.dart';

import 'package:ppcp_nutribreads/componentes/card_produto.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_list_prod.dart';

class ListaPoroducao extends StatelessWidget {
  const ListaPoroducao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          CabecalhoProd(
            buttonVoltar: 'Consultar Ordens',
            producao: '32324',
            linhaProd: 'Turno 01',
            data: '30/01/2026',
          ),
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Align(
                        alignment: Alignment.topCenter, // mude se quiser
                        child: Column(
                          children: [
                            CardProduto(
                              titulo: 'Pão Integral Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 746,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Forma Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 465,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Leite Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 465,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Manteiga Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 435,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Bisnaguinha Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 234,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Fofinho Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 973,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Hot-Dog Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 435,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Hamburguer Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 556,
                              status: 'Pendente',
                            ),
                            CardProduto(
                              titulo: 'Pão de Leitinho Nutribreads',
                              quantidade: '1000',
                              quantidadeProduzida: 165,
                              status: 'Pendente',
                            ),
                          ],
                        ),
                      ),
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
