import 'package:flutter/material.dart';
import 'package:billhard_app/colors/colors.dart';
import 'package:billhard_app/componentes/equipamentos_ajuste.dart';
import 'package:billhard_app/functions/mqtt_subscribe.dart';
import 'dart:async';

import 'package:billhard_app/services/notificacao_service.dart';

class CardEquipamentos extends StatefulWidget {
  final bool status;
  final double width;
  final double height;
  final String nome;
  final double larguraCardIcone;
  final double heightCardIcone;
  final String serialNumber;
  final String horaUpdate;
  final VoidCallback? onTap;

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
    this.onTap,
  });

  @override
  State<CardEquipamentos> createState() => CardEquipamentosState();
}

@override
class CardEquipamentosState extends State<CardEquipamentos> {
  Timer? timerStatus;
  String temperaturaRecebida = '---';
  String umidadeRecebida = '---';
  String dataHora = '---';

  @override
  void initState() {
    super.initState();

    timerStatus = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {});
    });

    iniciarMqtt();
  }

  Future<void> iniciarMqtt() async {
    await mqttSubscribe(
      topico: 'BHDC-0001/temperatura',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;
        setState(() {
          temperaturaRecebida = retorno.toString();
        });
      },
    );

    await mqttSubscribe(
      topico: 'BHDC-0001/umidade',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;
        setState(() {
          umidadeRecebida = retorno.toString();
        });
      },
    );
    await mqttSubscribe(
      topico: '${widget.serialNumber}/notificacao',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) async {
        await NotificacaoService.mostrar(
          titulo: 'Nova notificação',
          mensagem: retorno.toString(),
        );
      },
    );

    await mqttSubscribe(
      topico: 'BHDC-0001/data_hora',
      usuario: 'willianlunca',
      senha: 'senha@9090',
      onMensagem: (retorno) {
        if (!mounted) return;
        setState(() {
          dataHora = retorno.toString();
        });
      },
    );
  }

  @override
  void dispose() {
    timerStatus?.cancel();
    mqttDisconnect(); // se sua biblioteca possuir essa função
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color corStatus;

    if (dataHora.trim().isEmpty || dataHora == '---') {
      // Ainda não recebeu nenhuma informação do MQTT
      corStatus = Colors.grey;
    } else {
      try {
        final partes = dataHora.split(' ');
        final data = partes[0].split('/');
        final hora = partes[1].split(':');

        final DateTime ultimaComunicacao = DateTime(
          int.parse(data[2]),
          int.parse(data[1]),
          int.parse(data[0]),
          int.parse(hora[0]),
          int.parse(hora[1]),
          int.parse(hora[2]),
        );

        final diferenca = DateTime.now().difference(ultimaComunicacao);

        corStatus = diferenca.inSeconds > 10
            ? Colors.red
            : BillhardColors.verdePrincipal;
      } catch (_) {
        // Se o formato da data estiver inválido
        corStatus = Colors.grey;
      }
    }
    return Column(
      children: [
        Material(
          color: BillhardColors.bege,
          child: Ink(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                // Se estiver offline (cinza ou vermelho)
                if (corStatus == Colors.red || corStatus == Colors.grey) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: BillhardColors.bege,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Row(
                        children: [
                          Icon(
                            Icons.cloud_off,
                            color: Colors.red.shade700,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Equipamento Offline',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      content: const Text(
                        'Arraste o card para baixo para atualizar.\n\n'
                        'As configurações só estarão disponíveis quando o equipamento estiver online.',
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Entendi',
                            style: TextStyle(
                              color: BillhardColors.verdePrincipal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                  return; // Não abre o modal
                }

                // Equipamento online -> abre normalmente
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  builder: (_) =>
                      EquipamentosAjuste(serialNumber: widget.serialNumber),
                );
              },
              child: Container(
                width: widget.width,
                height: widget.height * 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade500, width: 1),
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
                            width: widget.larguraCardIcone,
                            height: widget.heightCardIcone,
                            decoration: BoxDecoration(
                              color: BillhardColors.verdeSecundario,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.bakery_dining,
                              size: 40,
                              color: BillhardColors.verdePrincipal,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: widget.larguraCardIcone / 7,
                            ),
                            width: widget.larguraCardIcone * 3.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.nome,
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
                                  width: widget.larguraCardIcone * 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Serial: ${widget.serialNumber}',
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
                                  width: widget.larguraCardIcone * 3,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Ultima Atualizaão: ${dataHora}',
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
                            width: widget.larguraCardIcone / 2,
                            height: widget.heightCardIcone / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.circle,
                              color: corStatus,
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
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: const Text(
                                        'Temperatura',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: widget.width * 0.6 / 1.55,
                                      height: widget.height * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        color: BillhardColors.terraCota,
                                      ),
                                      child: Center(
                                        child: Text(
                                          temperaturaRecebida == '---'
                                              ? temperaturaRecebida
                                              : '${temperaturaRecebida}°C',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
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
                                child: const Text(
                                  'Umididade',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: widget.width * 0.6 / 1.55,
                                height: widget.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: BillhardColors.verdeSecundario,
                                ),
                                child: Center(
                                  child: Text(
                                    umidadeRecebida == '---'
                                        ? umidadeRecebida
                                        : '${umidadeRecebida}%',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: BillhardColors.terraCota,
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
                            width: widget.width * 0.80,
                            height: widget.height * 0.23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey.shade500,
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
                                      Text(
                                        'Ver Parâmetros',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      Text(
                                        'Pressione para abrir controle',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey.shade600,
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
