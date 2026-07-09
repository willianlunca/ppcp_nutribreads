import 'package:flutter/material.dart';
import 'package:billhard_app/colors/colors.dart';

class CardModulos extends StatefulWidget {
  final IconData icone;
  final Color corIcone;
  final Color corBloco;
  final String titulo;
  final String descricao;
  final bool permissao;
  final VoidCallback? onTap;
  const CardModulos({
    super.key,
    required this.icone,
    required this.corIcone,
    required this.corBloco,
    required this.titulo,
    required this.descricao,
    required this.permissao,
    this.onTap,
  });

  @override
  State<CardModulos> createState() => _ModulosCardModulosState();
}

class _ModulosCardModulosState extends State<CardModulos> {
  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    int colunas = largura >= 1200
        ? 5
        : largura >= 900
        ? 4
        : largura >= 600
        ? 3
        : largura >= 400
        ? 2 // iPhone Pro Max
        : 1; // iPhone Pro e menores

    double larguraCard = (largura / colunas) - 40;
    double alturaCard = larguraCard * 0.9; // mantém proporção
    double tamanhoIcone = larguraCard * 0.4;
    double tamanhoTexto = larguraCard * 0.10;
    double tamanhoBox = larguraCard * 0.4;
    final radius = BorderRadius.circular(10);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          color: Colors.transparent,
          borderRadius: radius,
          clipBehavior: Clip.antiAlias, // recorta o ripple
          child: widget.permissao
              ? InkWell(
                  borderRadius: radius,

                  onTap: widget.permissao ? widget.onTap : null,
                  child: Ink(
                    width: larguraCard,
                    height: alturaCard,
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      border: Border.all(
                        color: Colors.grey.shade500,
                        width: 2.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.corBloco, //Colors.blue.shade50
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: tamanhoBox,
                            height: tamanhoBox,
                            child: Icon(
                              widget.icone,
                              size: tamanhoIcone / 1.5,
                              color: widget.corIcone,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            widget.titulo,
                            style: TextStyle(
                              fontSize: tamanhoTexto,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            widget.descricao,
                            style: TextStyle(
                              fontSize: tamanhoTexto / 1.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : InkWell(
                  borderRadius: radius,

                  onTap: widget.permissao
                      ? widget.onTap
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Você não tem permissão para acessar o modulo ${widget.titulo}',
                              ),
                              backgroundColor: NutribreadsColors.danger,
                            ),
                          );
                        },
                  child: Ink(
                    width: larguraCard,
                    height: alturaCard,
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      border: Border.all(
                        color: Colors.grey.shade500,
                        width: 2.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: widget.corBloco,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: tamanhoBox,
                                  height: tamanhoBox,
                                  child: Icon(
                                    widget.icone,
                                    size: tamanhoIcone / 1.5,
                                    color: widget.corIcone,
                                  ),
                                ),

                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(1.6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                      ),
                                      color: NutribreadsColors.danger,
                                    ),
                                    child: const Icon(
                                      Icons.lock_outline,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            widget.titulo,
                            style: TextStyle(
                              fontSize: tamanhoTexto,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Text(
                            widget.descricao,
                            style: TextStyle(
                              fontSize: tamanhoTexto / 1.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
