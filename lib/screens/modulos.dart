import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/componentes/modulos_cabecalho.dart';
import 'package:ppcp_nutribreads/componentes/modulos_card_modulos.dart';
import 'package:ppcp_nutribreads/componentes/ppcp_card_lista_colaboradores.dart';

class Modulos extends StatefulWidget {
  const Modulos({super.key});

  @override
  State<Modulos> createState() => _ModulosState();
}

class _ModulosState extends State<Modulos> {
  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    int colunas = largura > 1000
        ? 4
        : largura > 800
        ? 3
        : largura > 600
        ? 3
        : 2;

    double larguraCard = (largura / colunas) - 30;
    double alturaCard = larguraCard * 0.7; // mantém proporção
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: ModulosCabecalho(
                iniciaisNome: 'WL',
                nomeCompleto: 'Willian Lunca',
                cargo: 'Diretor',
                titulo: 'Selecione o Módulo',
                onTap: () {
                  // Lógica para o botão superior
                },
              ),
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      CardModulos(),
                      CardModulos(),
                      CardModulos(),
                      CardModulos(),
                      CardModulos(),
                      CardModulos(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* 
ListView(
          children: [
            Column(
              children: [
                ModulosCabecalho(
                  titulo: 'Módulos',
                  onTap: () {
                    // Lógica para o botão superior
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
*/
