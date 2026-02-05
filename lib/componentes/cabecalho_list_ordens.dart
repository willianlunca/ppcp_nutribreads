import 'package:flutter/material.dart';

class CabecalhoListOrdens extends StatelessWidget {
  final int quantidade_pendente;
  final VoidCallback? onTap;
  const CabecalhoListOrdens({
    super.key,
    required this.quantidade_pendente,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.60,
        height: 120,
        decoration: BoxDecoration(),
        margin: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3, left: 15, right: 3),
                  child: Icon(Icons.refresh, size: 14, color: Colors.black),
                ),
                InkWell(
                  onTap: onTap,
                  child: Text(
                    'Atualizar Lista de Produção',
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
              children: [
                Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Text(
                    'Selecione:',
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
                    'Ordens de Produção',
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
                    '$quantidade_pendente Ordens pendentes',
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
