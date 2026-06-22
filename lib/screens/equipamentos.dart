import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/componentes/card_equipamentos.dart';
import 'package:ppcp_nutribreads/screens/modulos.dart';

class Equipamentos extends StatefulWidget {
  const Equipamentos({super.key});

  @override
  State<Equipamentos> createState() => _EquipamentosState();
}

class _EquipamentosState extends State<Equipamentos> {
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
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: alturaTela * 1.1,
              decoration: BoxDecoration(
                color: NutribreadsColors.azulEscuro,
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
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(top: alturaTela / 5),
              height: alturaTela * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //border: Border.all(color: Colors.grey.shade300, width: 1.0),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
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
              child: Container(
                //color: Colors.amber.shade50,
                width: MediaQuery.of(context).size.width * 0.9,
                //margin: EdgeInsets.only(top: alturaTela / 5),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(top: alturaTela / 10),
                      child: CardEquipamentos(
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


/**
 * 
 * Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(),
                                        child: Icon(
                                          Icons.inventory_2,
                                          color: NutribreadsColors.azulMedio,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: larguraTela / 10,
                                        ),
                                        child: Text(
                                          'Farinha de trigo Herança Holandeza',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
 */