import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';

class EquipamentosAjuste extends StatelessWidget {
  final String serialNumber;

  EquipamentosAjuste({super.key, required this.serialNumber});

  @override
  Widget build(BuildContext context) {
    double alturaListViewRetorno = 30;
    double largura = MediaQuery.of(context).size.width;

    int colunas = largura >= 1200
        ? 5
        : largura >= 900
        ? 4
        : largura >= 600
        ? 3
        : largura >= 400
        ? 2
        : 1;

    double larguraTela = (largura / colunas) - 40;
    double alturaTela = larguraTela * 0.9;
    double tamanhoTexto = larguraTela * 0.10;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          const SizedBox(height: 12),

          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: NutribreadsColors.azulMedio,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Parâmetros',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Column(
                  children: [
                    SizedBox(
                      child: Text(
                        'Câmara de fermentação',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Serial: ${serialNumber}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Container(
                      width: largura * 0.9,
                      height: alturaTela * 2,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.thermostat_auto_outlined,
                                  color: NutribreadsColors.azulEscuro,
                                  size: tamanhoTexto * 2,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Temperatura',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(width: tamanhoTexto * 2),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Defina a temperatura desejada para a câmara.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: alturaTela / 2,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade500,
                                width: 1,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: larguraTela / 3,
                                    height: alturaTela / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.purple.shade100,
                                    ),
                                  ),
                                  Container(
                                    width: larguraTela / 1.5,
                                    height: alturaTela / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '25C',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: larguraTela / 3,
                                    height: alturaTela / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.purple.shade100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // quantos widgets quiser...
              ],
            ),
          ),
        ],
      ),
    );
  }
}
