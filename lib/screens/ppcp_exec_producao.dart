import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/componentes/ppcp_cabecalho_exec_producao.dart';
import 'package:ppcp_nutribreads/componentes/ppcp_card_exec_producao.dart';
import 'package:ppcp_nutribreads/functions/cronometro.dart';
import 'package:ppcp_nutribreads/screens/ppcp_lista_produtos_ordens.dart';

class ExecProducao extends StatefulWidget {
  const ExecProducao({super.key});

  @override
  State<ExecProducao> createState() => _ExecProducaoState();
}

class _ExecProducaoState extends State<ExecProducao> {
  String numeroUsers =
      '3'; // Deve vir da api os usuarios que estão executando a produção.
  String linhaProd =
      'Linha 01'; // Deve vir da api qual linha de produção está executando.
  String progresso = '10'; // Deve vir da api o progresso da produção.
  String meta = '300';
  int porcentagem = 0;
  int qtdProduzida = 0;
  bool mostrarCard = false;
  bool pausar = false;
  Cronometro? cronometro;
  String tempo = '00:00:00';

  @override
  void initState() {
    super.initState();

    cronometro = Cronometro(
      onTick: (novoTempo) {
        setState(() {
          tempo = novoTempo;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.brown.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.93,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progresso',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '$porcentagem %',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 12,
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(),
                                child: LinearProgressIndicator(
                                  value: porcentagem / 100,
                                  backgroundColor: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    NutribreadsColors.azulEscuro,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      '$progresso / $meta',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.93,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            width: (MediaQuery.of(context).size.width * 0.30),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.inventory_2,
                                      size: 20,
                                      color: Colors.grey.shade700,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        'Produzido',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        qtdProduzida.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4, top: 4),
                                      child: Text(
                                        'Un',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            width: (MediaQuery.of(context).size.width * 0.30),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.my_location,
                                      size: 20,
                                      color: Colors.grey.shade700,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        'Meta',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        meta,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4, top: 4),
                                      child: Text(
                                        'Un',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            width: (MediaQuery.of(context).size.width * 0.30),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 20,
                                      color: Colors.grey.shade700,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        'Tempo',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                        tempo,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (mostrarCard)
                      CardExecProducao(
                        onFinalizar: () {
                          setState(() {
                            mostrarCard = false;
                            cronometro?.resetar();
                            pausar = false;
                          });
                        },
                        onPausar: () {
                          setState(() {
                            if (pausar == false) {
                              pausar = true;
                            } else {
                              pausar = false;
                            }
                          });

                          if (pausar) {
                            cronometro?.pausar();
                          } else {
                            cronometro?.iniciar(); // ▶ retoma
                          }
                        },
                        onAdicionar01: () {
                          setState(() {
                            qtdProduzida += 1;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onAdicionar05: () {
                          setState(() {
                            qtdProduzida += 5;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onAdicionar10: () {
                          setState(() {
                            qtdProduzida += 10;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onAdicionar50: () {
                          setState(() {
                            qtdProduzida += 50;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onAdicionar100: () {
                          setState(() {
                            qtdProduzida += 100;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onRemover01: () {
                          setState(() {
                            qtdProduzida -= 1;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },

                        onRemover05: () {
                          setState(() {
                            qtdProduzida -= 5;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onRemover10: () {
                          setState(() {
                            qtdProduzida -= 10;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onRemover50: () {
                          setState(() {
                            qtdProduzida -= 50;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                        onRemover100: () {
                          setState(() {
                            qtdProduzida -= 100;
                            porcentagem = (qtdProduzida / int.parse(meta) * 100)
                                .toInt();
                          });
                        },
                      ),

                    if (!mostrarCard)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.93,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            print('Botão Iniciar Produção Pressionado');
                            cronometro?.iniciar();
                            print(tempo);
                            setState(() {
                              mostrarCard = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                NutribreadsColors.azulMedio, // cor do botão
                            foregroundColor: Colors.white, // cor do texto
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 8,
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text('Iniciar Produção'),
                              ),
                            ],
                          ),
                        ),
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
