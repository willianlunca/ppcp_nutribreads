import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_exec_producao.dart';
import 'package:ppcp_nutribreads/screens/lista_produtos_ordens.dart';

class ExecProducao extends StatelessWidget {
  const ExecProducao({super.key});

  @override
  Widget build(BuildContext context) {
    String numeroUsers =
        '3'; // Deve vir da api os usuarios que estão executando a produção.
    String linhaProd =
        'Linha 01'; // Deve vir da api qual linha de produção está executando.
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          children: [
            CabecalhoExecProducao(
              buttonSuperior: 'Produtos da Ordem',
              ordeProducao: 'OP-2026-0147',
              linhaProd: linhaProd,
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
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              width: 600,
              height: 200,
              margin: EdgeInsets.only(top: 20),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Produto',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pão Integral Multigrãos',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 22,
                              color: Colors.grey.shade700,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4),
                              child: Text(
                                numeroUsers,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            linhaProd,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
