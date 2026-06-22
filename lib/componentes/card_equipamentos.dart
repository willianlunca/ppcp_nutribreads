import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';

class CardEquipamentos extends StatelessWidget {
  final bool status;
  final double width;
  final double height;
  final String nome;
  final double larguraCardIcone;
  final double heightCardIcone;
  final String serialNumber;
  final String horaUpdate;

  const CardEquipamentos({
    super.key,
    required this.status,
    required this.width,
    required this.height,
    required this.nome,
    required this.larguraCardIcone,
    required this.heightCardIcone,
    required this.serialNumber,
    required this.horaUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /** Card de equipamentos */
        Material(
          child: Ink(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: status ? () => print('Equipamento selecionado') : null,
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300, width: 1),

                  //color: NutribreadsColors.azulMedio,
                  //color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: larguraCardIcone,
                            height: heightCardIcone,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.bakery_dining,
                              size: 40,
                              color: NutribreadsColors.azulMedio,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: larguraCardIcone / 7),
                            width: larguraCardIcone * 3.5,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start, // <-- ADICIONE ISSO
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      nome,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 0),
                                  width: larguraCardIcone * 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Serial: ${serialNumber}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 0),
                                  width: larguraCardIcone * 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Ultima Atualizaão: ${horaUpdate}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: larguraCardIcone / 2,
                            height: heightCardIcone / 2,
                            decoration: BoxDecoration(
                              //color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Temperatura',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6 / 2,
                                      height: height * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade300,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '25°C',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Umididade',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.6 / 2,
                                height: height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                ),
                                child: Center(
                                  child: Text(
                                    '61%',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.80,
                            height: height * 0.23,

                            //margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Ver Parâmetros',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ),

                                      Container(
                                        child: Text(
                                          'Pressione para abrir controle',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey.shade600,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
