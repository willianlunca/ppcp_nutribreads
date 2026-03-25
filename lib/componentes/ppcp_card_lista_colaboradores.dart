import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';

class CardListaColaboradores extends StatefulWidget {
  final String iniciaisNome;
  final String nomeCompleto;
  final String cargo;
  CardListaColaboradores({
    super.key,
    required this.iniciaisNome,
    required this.nomeCompleto,
    required this.cargo,
  });

  @override
  State<CardListaColaboradores> createState() => _CardListaColaboradoresState();
}

class _CardListaColaboradoresState extends State<CardListaColaboradores> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 200,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: NutribreadsColors.azulMedio,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                widget.iniciaisNome,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  widget.nomeCompleto,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  widget.cargo,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
