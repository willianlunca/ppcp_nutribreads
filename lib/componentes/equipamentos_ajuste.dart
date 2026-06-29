import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:ppcp_nutribreads/functions/mqtt_publish.dart';
import 'package:ppcp_nutribreads/functions/mqtt_subscribe.dart';

class EquipamentosAjuste extends StatefulWidget {
  final String serialNumber;

  const EquipamentosAjuste({super.key, required this.serialNumber});

  @override
  State<EquipamentosAjuste> createState() => _EquipamentosAjusteState();
}

class _EquipamentosAjusteState extends State<EquipamentosAjuste> {
  final ValueNotifier<int> setTemperatura = ValueNotifier<int>(0);
  final ValueNotifier<int> setUmidade = ValueNotifier<int>(12);
  final ValueNotifier<int> setTempVaporAtivo = ValueNotifier<int>(10);
  final ValueNotifier<int> setTempVaporDesat = ValueNotifier<int>(40);
  bool status = false;
  bool iluminacao = false;
  bool ventilacao = false;
  @override
  void initState() {
    super.initState();

    iniciarMqtt();
  }

  void iniciarMqtt() async {
    await mqttSubscribe(
      topico: '${widget.serialNumber}/resposta/estado/equipamento',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        setState(() {
          status = retorno.toString().toLowerCase() == 'true';
        });

        print('Estado do equipamento: $status');
      },
    );
    await mqttSubscribe(
      topico: '${widget.serialNumber}/resposta/estado/iluminacao',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        setState(() {
          iluminacao = retorno.toString().toLowerCase() == 'true';
        });

        print('Estado da Iluminacao do equipamento: $iluminacao');
      },
    );
    await mqttSubscribe(
      topico: '${widget.serialNumber}/resposta/estado/ventilacao',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        setState(() {
          ventilacao = retorno.toString().toLowerCase() == 'true';
        });

        print('Estado da ventilação  do equipamento: $ventilacao');
      },
    );

    await mqttSubscribe(
      topico: '${widget.serialNumber}/resposta/set/temperatura',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        final int? valor = int.tryParse(retorno.toString());

        if (valor != null) {
          setState(() {
            setTemperatura.value = valor;
          });

          print('Temperatura recebida: ${setTemperatura.value}');
        } else {
          print('Erro ao converter temperatura: $retorno');
        }
      },
    );
    await mqttSubscribe(
      topico: '${widget.serialNumber}/resposta/set/umidade',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        final int? valor = int.tryParse(retorno.toString());

        if (valor != null) {
          setState(() {
            setUmidade.value = valor;
          });

          print('Umidade recebida: ${setUmidade.value}');
        } else {
          print('Erro ao converter Umidade: $retorno');
        }
      },
    );
    await mqttSubscribe(
      topico: '${widget.serialNumber}/resposta/set/vapor_ativado',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        final int? valor = int.tryParse(retorno.toString());

        if (valor != null) {
          setState(() {
            setTempVaporAtivo.value = valor;
          });

          print('Vapor Ativado recebido: ${setTempVaporAtivo.value}');
        } else {
          print('Erro ao converter Vapor Ativado: $retorno');
        }
      },
    );

    await mqttSubscribe(
      topico: '${widget.serialNumber}/resposta/set/vapor_desativado',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        final int? valor = int.tryParse(retorno.toString());

        if (valor != null) {
          setState(() {
            setTempVaporDesat.value = valor;
          });
          print('Vapor desativado: ${setTempVaporDesat.value}');
        } else {
          print('Erro ao converter Vapor desativado $retorno');
        }
      },
    );
  }

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
                        'Serial: ${widget.serialNumber}',
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
                                          onTap: () async {
                                            if (setTemperatura.value > 0) {
                                              setTemperatura.value--;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/temperatura',
                                              mensagem:
                                                  '${setTemperatura.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                          onTap: () async {
                                            if (setTemperatura.value < 60) {
                                              setTemperatura.value++;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/temperatura',
                                              mensagem:
                                                  '${setTemperatura.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                      'Faixa recomendada: 20°C a 40°C',
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
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Icon(
                                  Icons.trending_down,
                                  color: BillhardColors.verdePrincipal,
                                  size: tamanhoTexto * 2,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Range Temperatura',
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
                                  'Defina o range de queda de temperatura',
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
                                          onTap: () async {
                                            if (setTemperatura.value > 0) {
                                              setTemperatura.value--;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/temperatura',
                                              mensagem:
                                                  '${setTemperatura.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                          onTap: () async {
                                            if (setTemperatura.value < 60) {
                                              setTemperatura.value++;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/temperatura',
                                              mensagem:
                                                  '${setTemperatura.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                      'Faixa recomendada: 2°C a 5°C',
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
                                          onTap: () async {
                                            if (setUmidade.value > 15) {
                                              setUmidade.value--;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/umidade',
                                              mensagem: '${setUmidade.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                          onTap: () async {
                                            if (setUmidade.value < 95) {
                                              setUmidade.value++;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/umidade',
                                              mensagem: '${setUmidade.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Icon(
                                  Icons.trending_down,
                                  color: BillhardColors.verdePrincipal,
                                  size: tamanhoTexto * 2,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Range Temperatura',
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
                                  'Defina o range de queda de temperatura',
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
                                          onTap: () async {
                                            if (setTemperatura.value > 0) {
                                              setTemperatura.value--;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/temperatura',
                                              mensagem:
                                                  '${setTemperatura.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                          onTap: () async {
                                            if (setTemperatura.value < 60) {
                                              setTemperatura.value++;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/temperatura',
                                              mensagem:
                                                  '${setTemperatura.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                      'Faixa recomendada: 5% a 8% UR',
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
                                          onTap: () async {
                                            if (setTempVaporAtivo.value > 10) {
                                              setTempVaporAtivo.value--;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/vapor_ativado',
                                              mensagem:
                                                  '${setTempVaporAtivo.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
                                            print('Reduzir Tempo Vapor');
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
                                          onTap: () async {
                                            if (setTempVaporAtivo.value < 180) {
                                              setTempVaporAtivo.value++;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/vapor_ativado',
                                              mensagem:
                                                  '${setTempVaporAtivo.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                    Icons.timer_off_outlined,
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
                                          onTap: () async {
                                            if (setTempVaporDesat.value > 40) {
                                              setTempVaporDesat.value--;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/vapor_desativado',
                                              mensagem:
                                                  '${setTempVaporDesat.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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
                                          onTap: () async {
                                            if (setTempVaporDesat.value < 240) {
                                              setTempVaporDesat.value++;
                                            }
                                            await mqttPublish(
                                              topico:
                                                  '${widget.serialNumber}/comando/vapor_desativado',
                                              mensagem:
                                                  '${setTempVaporDesat.value}',
                                              usuario: 'willianlunca',
                                              senha: 'senha@9090',
                                              onSucesso: () {},
                                              onErro: (erro) {
                                                print(erro);
                                              },
                                            );
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

                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: alturaTela * 1.26,
                  width: largura * 0.9, // altura do card de ativar ou desavivar
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade500, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.power_settings_new,
                              size: 32,
                              color: BillhardColors.verdePrincipal,
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              'Equipamento',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: BillhardColors.verdePrincipal,
                              ),
                            ),

                            const Spacer(),

                            CupertinoSwitch(
                              value: status,
                              activeTrackColor: BillhardColors.verdePrincipal,
                              trackColor: Colors.grey.shade700,
                              thumbColor: Colors.white,
                              onChanged: (valor) async {
                                await mqttPublish(
                                  topico:
                                      '${widget.serialNumber}/comando/estado/equipamento',
                                  mensagem: '${valor}',
                                  usuario: 'willianlunca',
                                  senha: 'senha@9090',
                                  onSucesso: () {
                                    print('Comando enviado com sucesso');
                                  },
                                  onErro: (erro) {
                                    print(erro);
                                  },
                                );
                                setState(() {
                                  status = valor;
                                });
                              },
                            ),

                            const SizedBox(width: 12),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: status
                                    ? BillhardColors.verdePrincipal
                                    : Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status ? 'LIGADO' : 'DESLIGADO',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        /** Container para controle de Iluminaão */
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,

                              size: 32,
                              color: BillhardColors.verdePrincipal,
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              'Iluminação',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: BillhardColors.verdePrincipal,
                              ),
                            ),

                            const Spacer(),

                            CupertinoSwitch(
                              value: iluminacao,
                              activeTrackColor: BillhardColors.verdePrincipal,
                              trackColor: Colors.grey.shade700,
                              thumbColor: Colors.white,
                              onChanged: (valor) async {
                                await mqttPublish(
                                  topico:
                                      '${widget.serialNumber}/comando/estado/iluminacao',
                                  mensagem: '${valor}',
                                  usuario: 'willianlunca',
                                  senha: 'senha@9090',
                                  onSucesso: () {
                                    print('Comando enviado com sucesso');
                                  },
                                  onErro: (erro) {
                                    print(erro);
                                  },
                                );
                                setState(() {
                                  iluminacao = valor;
                                });
                              },
                            ),

                            const SizedBox(width: 12),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: iluminacao
                                    ? BillhardColors.verdePrincipal
                                    : Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                iluminacao ? 'LIGADO' : 'DESLIGADO',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          //border: Border(
                          //bottom: BorderSide(color: Colors.grey, width: 1),
                          //),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.wind_power_outlined,
                              size: 32,
                              color: BillhardColors.verdePrincipal,
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              'Ventilação ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: BillhardColors.verdePrincipal,
                              ),
                            ),

                            const Spacer(),

                            CupertinoSwitch(
                              value: ventilacao,
                              activeTrackColor: BillhardColors.verdePrincipal,
                              trackColor: Colors.grey.shade700,
                              thumbColor: Colors.white,
                              onChanged: (valor) async {
                                await mqttPublish(
                                  topico:
                                      '${widget.serialNumber}/comando/estado/ventilacao',
                                  mensagem: '${valor}',
                                  usuario: 'willianlunca',
                                  senha: 'senha@9090',
                                  onSucesso: () {
                                    print('Comando enviado com sucesso');
                                  },
                                  onErro: (erro) {
                                    print(erro);
                                  },
                                );
                                setState(() {
                                  ventilacao = valor;
                                });
                              },
                            ),

                            const SizedBox(width: 12),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: ventilacao
                                    ? BillhardColors.verdePrincipal
                                    : Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                ventilacao ? 'LIGADO' : 'DESLIGADO',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        /** Container para controle de Iluminaão */
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: alturaTela * 0.4,
                  width: largura * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: BillhardColors.bege,
                          title: const Text(
                            'Salvar Configurações',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          content: const Text(
                            'Deseja realmente salvar as configurações deste equipamento?',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: BillhardColors.verdePrincipal,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final scaffoldMessenger = ScaffoldMessenger.of(
                                  context,
                                );

                                Navigator.pop(context);

                                await mqttPublish(
                                  topico:
                                      '${widget.serialNumber}/comando/estado/atualizacao',
                                  mensagem: 'true',
                                  usuario: 'willianlunca',
                                  senha: 'senha@9090',
                                  onSucesso: () {},
                                  onErro: (erro) {
                                    print(erro);
                                  },
                                );

                                if (!mounted) return;

                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        BillhardColors.verdePrincipal,
                                    content: const Text(
                                      'Configurações salvas com sucesso!',
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                  color: BillhardColors.terraCota,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BillhardColors.terraCota,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Salvar Configurações',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
