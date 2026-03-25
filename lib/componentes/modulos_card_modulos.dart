import 'package:flutter/material.dart';

class CardModulos extends StatefulWidget {
  const CardModulos({super.key});

  @override
  State<CardModulos> createState() => _ModulosCardModulosState();
}

class _ModulosCardModulosState extends State<CardModulos> {
  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    int colunas = largura > 1000
        ? 4
        : largura > 800
        ? 3
        : largura > 600
        ? 3
        : 2;

    double larguraCard = (largura / colunas) - 30;
    double alturaCard = larguraCard * 0.7; // mantém proporção
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: larguraCard,
          height: alturaCard,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.brown.shade600, width: 0.8),
          ),
        ),
      ),
    );
    ;
  }
}
