import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_exec_producao.dart';
import 'package:ppcp_nutribreads/screens/lista_produtos_ordens.dart';

class ExecProducao extends StatelessWidget {
  const ExecProducao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          children: [
            CabecalhoExecProducao(
              buttonSuperior: 'Produtos da Ordem',
              producao: 'OP-2026-0147',
              linhaProd: 'Linha 01',
              data: '03/02/2026',
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
      ),
    );
  }
}
