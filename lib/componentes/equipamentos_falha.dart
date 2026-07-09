import 'package:flutter/material.dart';
import 'package:billhard_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:billhard_app/functions/mqtt_publish.dart';
import 'package:billhard_app/functions/mqtt_subscribe.dart';

class EquipamentosFalha extends StatefulWidget {
  final String serialNumber;

  const EquipamentosFalha({super.key, required this.serialNumber});

  @override
  State<EquipamentosFalha> createState() => _EquipamentosFalhaState();
}

class _EquipamentosFalhaState extends State<EquipamentosFalha> {
  final ValueNotifier<int> setTemperatura = ValueNotifier<int>(0);
  final ValueNotifier<int> setRangeTemperatura = ValueNotifier<int>(0);
  final ValueNotifier<int> setUmidade = ValueNotifier<int>(12);
  final ValueNotifier<int> setRangeUmidade = ValueNotifier<int>(0);
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
      topico: '${widget.serialNumber}/resposta/set/range_temperatura',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        final int? valor = int.tryParse(retorno.toString());

        if (valor != null) {
          setState(() {
            setRangeTemperatura.value = valor;
          });

          print('Range Temperatura recebida: ${setRangeTemperatura.value}');
        } else {
          print('Erro ao converter range temperatura: $retorno');
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
      topico: '${widget.serialNumber}/resposta/set/range_umidade',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;

        final int? valor = int.tryParse(retorno.toString());

        if (valor != null) {
          setState(() {
            setRangeUmidade.value = valor;
          });

          print('Range Umidade recebida: ${setUmidade.value}');
        } else {
          print('Erro ao converter Range Umidade: $retorno');
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
      height: MediaQuery.of(context).size.height * 0.90,
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
            'Logs de Falhas',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),

                            //width: larguraTela * 0.45,
                            decoration: BoxDecoration(
                              color: BillhardColors.terraCota,
                              border: Border.all(
                                color: Colors.grey.shade800,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.sort, size: 15, color: Colors.white),
                                Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    'Todas',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
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
