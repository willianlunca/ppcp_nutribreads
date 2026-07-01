import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/componentes/card_equipamentos.dart';
import 'package:ppcp_nutribreads/screens/modulos.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ppcp_nutribreads/functions/mqtt_subscribe.dart';

class Equipamentos extends StatefulWidget {
  const Equipamentos({super.key});

  @override
  State<Equipamentos> createState() => _EquipamentosState();
}

class _EquipamentosState extends State<Equipamentos>
    with WidgetsBindingObserver {
  final GlobalKey<CardEquipamentosState> cardKey =
      GlobalKey<CardEquipamentosState>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool atualizando = false;

  Future<void> atualizarCard() async {
    if (atualizando) return;

    atualizando = true;

    try {
      await cardKey.currentState?.iniciarMqtt();
    } finally {
      atualizando = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        atualizarCard();
      });
    }
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

    return Scaffold(
      backgroundColor: BillhardColors.bege,
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: alturaTela * 1.1,
              decoration: BoxDecoration(
                color: BillhardColors.verdePrincipal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(alturaTela / 8),
                  bottomRight: Radius.circular(alturaTela / 8),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: larguraTela / 10),
                        child: Material(
                          color: Colors.transparent,
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Modulos(),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: larguraTela / 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lista de Equipamentos',
                                style: TextStyle(
                                  fontSize: tamanhoTexto * 1.2,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Selecione o Equipamento',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: tamanhoTexto / 1.2,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: alturaTela / 5),
              height: alturaTela * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //border: Border.all(color: Colors.grey.shade300, width: 1.0),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(top: alturaTela / 5),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar Equipamento',
                        hintText: 'Digite para buscar',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: alturaTela / 10,
                          horizontal: 12,
                        ),

                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (valor) {
                        print(valor); // texto digitado
                      },
                    ),
                  ),

                  /*Adicionar card de equipamentos aqui */
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: Colors.black, // cor da “bolinha”/ícone que gira
                backgroundColor:
                    BillhardColors.verdeSecundario, // cor do círculo de fundo
                strokeWidth: 2.5,
                child: Container(
                  //color: Colors.amber.shade50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  //margin: EdgeInsets.only(top: alturaTela / 5),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        //margin: EdgeInsets.only(top: alturaTela / 10),
                        child: CardEquipamentos(
                          key: cardKey,
                          status: true,
                          width: largura,
                          height: alturaTela * 2.1,
                          nome: 'Câmara de fermentação',
                          larguraCardIcone: largura * 0.15,
                          heightCardIcone: alturaTela * 0.4,
                          serialNumber: 'BHDC-0001',
                          horaUpdate: '08:35:33',
                        ),
                      ),
                    ],
                  ),
                ),
                onRefresh: () async {
                  await cardKey.currentState?.iniciarMqtt();
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: alturaTela / 2,
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
