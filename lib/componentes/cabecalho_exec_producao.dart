import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/screens/lista_ordens.dart';

class CabecalhoExecProducao extends StatelessWidget {
  final String buttonVoltar;
  final String producao;
  final String linhaProd;
  final String data;
  final VoidCallback? onTap;

  const CabecalhoExecProducao({
    super.key,
    required this.buttonVoltar,
    required this.producao,
    required this.linhaProd,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.60,
        height: 130,
        decoration: BoxDecoration(),
        margin: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3, left: 15),
                  child: Icon(Icons.arrow_back, size: 14, color: Colors.black),
                ),
                InkWell(
                  //DEVE SER SUBISTITUIDO POR LOGICAS E PUXAR OS ITENS REAIS DA LISTA.
                  onTap: onTap,
                  child: Text(
                    buttonVoltar,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Text(
                    'OP: $producao',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    'Itens da Ordem',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    '$linhaProd - $data',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
