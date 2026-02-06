import 'package:flutter/material.dart';

import 'package:ppcp_nutribreads/componentes/card_produto.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_list_prod.dart';
import 'package:ppcp_nutribreads/screens/exec_producao.dart';
import 'package:ppcp_nutribreads/screens/lista_ordens.dart';

class ListaPoroducao extends StatelessWidget {
  const ListaPoroducao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          CabecalhoProd(
            buttonSuperior: 'Consultar Ordens',
            producao: '32324',
            linhaProd: 'Turno 01',
            data: '30/01/2026',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListaOrdens()),
              );
            },
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ExecProducao(),
                                  ),
                                );
                              },
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
