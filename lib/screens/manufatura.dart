import 'package:flutter/material.dart';
import 'package:billhard_app/colors/colors.dart';
import 'package:billhard_app/screens/modulos.dart';

class Manufatura extends StatefulWidget {
  const Manufatura({super.key});

  @override
  State<Manufatura> createState() => _ManufaturaState();
}

class _ManufaturaState extends State<Manufatura> {
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
                                'Adicionar Ingredientes',
                                style: TextStyle(
                                  fontSize: tamanhoTexto * 1.2,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Preencha os dados do item',
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 1.0),

                boxShadow: [
                  /*BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ), */
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(top: alturaTela / 5),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nome do Ingrediente',
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
                  Container(
                    margin: EdgeInsets.only(top: alturaTela / 8),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: alturaListViewRetorno,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Column(
                                children: [
                                  Material(
                                    child: Ink(
                                      height: alturaTela / 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                      ),

                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(6),

                                        onTap: () => {
                                          debugPrint(
                                            'Botão do Ingrediente pressionado',
                                          ),
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: larguraTela / 14,
                                              ),
                                              child: Icon(
                                                Icons.inventory_2,
                                                color:
                                                    NutribreadsColors.azulMedio,
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
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(top: alturaTela / 5),
                child: ListView(children: [Column(children: [
                        
                      ],
                    )]),
              ),
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