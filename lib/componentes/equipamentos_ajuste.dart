import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';

class EquipamentosAjuste extends StatelessWidget {
  final String serialNumber;

  EquipamentosAjuste({super.key, required this.serialNumber});

  final ValueNotifier<int> setTemperatura = ValueNotifier<int>(25);
  final ValueNotifier<int> setUmidade = ValueNotifier<int>(15);
  final ValueNotifier<int> setTempVaporAtivo = ValueNotifier<int>(30);
  final ValueNotifier<int> setTempVaporDesat = ValueNotifier<int>(40);

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
    return Container(
      decoration: const BoxDecoration(
        color: BillhardColors.bege,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          const SizedBox(height: 12),

          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: BillhardColors.verdePrincipal,
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
                        'Serial: $serialNumber',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Container(
                      width: largura * 0.9,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.thermostat_auto_outlined,
                                  color: BillhardColors.verdePrincipal,
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
                          Column(
                            children: [
                              Container(
                                height: alturaTela / 2,
                                width: largura * 0.9,
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
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setTemperatura.value > 0) {
                                              setTemperatura.value--;
                                            }
                                            print('Diminuir temperatura');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: larguraTela / 1.5,
                                        height: alturaTela / 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: ValueListenableBuilder<int>(
                                            valueListenable: setTemperatura,
                                            builder:
                                                (
                                                  context,
                                                  valorTemperatura,
                                                  child,
                                                ) {
                                                  return Text(
                                                    '${valorTemperatura}°C',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setTemperatura.value < 60) {
                                              setTemperatura.value++;
                                            }
                                            print('Aumentar temperatura');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: alturaTela / 3,
                                width: largura * 0.9,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Faixa recomendada: 20°C s 40°C',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.water_drop_outlined,
                                    color: BillhardColors.verdePrincipal,
                                    size: tamanhoTexto * 2,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Umidade',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: alturaTela / 2,
                                width: largura * 0.9,
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
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setUmidade.value > 15) {
                                              setUmidade.value--;
                                            }
                                            print('Diminuir Umidade');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: larguraTela / 1.5,
                                        height: alturaTela / 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: ValueListenableBuilder<int>(
                                            valueListenable: setUmidade,
                                            builder:
                                                (context, valorUmidade, child) {
                                                  return Text(
                                                    '$valorUmidade%',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setUmidade.value < 95) {
                                              setUmidade.value++;
                                            }
                                            print('Aumentar Umidade');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: alturaTela / 3,
                                width: largura * 0.9,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Faixa recomendada: 20% s 90%',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.timer_outlined,
                                    color: BillhardColors.verdePrincipal,
                                    size: tamanhoTexto * 2,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Vapor Ativado',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: alturaTela / 2,
                                width: largura * 0.9,
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
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setTempVaporAtivo.value > 10) {
                                              setTempVaporAtivo.value--;
                                            }
                                            print('Diminuir Tempo Vapor');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: larguraTela / 1.5,
                                        height: alturaTela / 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: ValueListenableBuilder<int>(
                                            valueListenable: setTempVaporAtivo,
                                            builder:
                                                (context, valorVapor, child) {
                                                  return Text(
                                                    '${valorVapor}S',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setTempVaporAtivo.value < 180) {
                                              setTempVaporAtivo.value++;
                                            }
                                            print('Aumentar Tempo Vapor');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: alturaTela / 3,
                                width: largura * 0.9,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Faixa recomendada: 20 S a 120 S',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.water_drop_outlined,
                                    color: BillhardColors.verdePrincipal,
                                    size: tamanhoTexto * 2,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Vapor Desativado',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: alturaTela / 2,
                                width: largura * 0.9,
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
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setTempVaporDesat.value > 40) {
                                              setTempVaporDesat.value--;
                                            }
                                            print('Diminuir Vapor Desativado');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: larguraTela / 1.5,
                                        height: alturaTela / 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: ValueListenableBuilder<int>(
                                            valueListenable: setTempVaporDesat,
                                            builder:
                                                (
                                                  context,
                                                  valorVaporDesativado,
                                                  child,
                                                ) {
                                                  return Text(
                                                    '${valorVaporDesativado}S',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            if (setTempVaporDesat.value < 240) {
                                              setTempVaporDesat.value++;
                                            }
                                            print('Aumentar Umidade');
                                          },
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Container(
                                            width: larguraTela / 3,
                                            height: alturaTela / 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: BillhardColors.terraCota,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: alturaTela / 3,
                                width: largura * 0.9,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Faixa recomendada: 60 s a 180 s',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w600,
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

                // quantos widgets quiser...
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: alturaTela / 2,
            decoration: BoxDecoration(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
