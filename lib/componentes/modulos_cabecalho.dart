import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/screens/login.dart';
import 'package:ppcp_nutribreads/services/auth.dart';

class ModulosCabecalho extends StatelessWidget {
  final String titulo;
  final String iniciaisNome;
  final String nomeCompleto;
  final String cargo;
  final VoidCallback? onTap;

  const ModulosCabecalho({
    super.key,
    required this.titulo,
    required this.iniciaisNome,
    required this.nomeCompleto,
    required this.cargo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    int colunas = largura >= 1200
        ? 5
        : largura >= 900
        ? 4
        : largura >= 600
        ? 3
        : largura >= 400
        ? 2 // iPhone Pro Max
        : 1; // iPhone Pro e menores

    double larguraCard = (largura / colunas) - 40;
    double alturaCard = larguraCard * 0.9; // mantém proporção
    double tamanhoTexto = larguraCard * 0.10;
    double tamanhoBox = larguraCard * 0.4;
    return SizedBox(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        constraints: BoxConstraints(minHeight: alturaCard / 1.2),
        margin: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: tamanhoBox * 2.2,
                  height: tamanhoBox / 1.2,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Container(
                              width: alturaCard / 5,
                              height: alturaCard / 5,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: NutribreadsColors.azulEscuro,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  iniciaisNome,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: tamanhoTexto / 1.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                              nomeCompleto,
                              style: TextStyle(
                                fontSize: tamanhoTexto / 1.4,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Text(
                                  cargo,
                                  style: TextStyle(
                                    fontSize: tamanhoTexto / 1.5,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Area de Trabalho',
                                softWrap: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: tamanhoTexto,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: tamanhoTexto * 1.2,
                      color: Colors.black,
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(4),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: Text(
                              'Sair da Conta',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            content: Text(
                              'Deseja realmente sair?',
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: NutribreadsColors.azulEscuro,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);

                                  await AuthService().signOut();

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Login(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  'Sair',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      /*await AuthService().signOut();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const Login()),
                        (route) => false,
                      );
                      */
                      // Aqui você pode adicionar a lógica para realizar o logout
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.logout,
                        size: 23,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
