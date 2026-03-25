import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';

class CabecalhoColaboradores extends StatelessWidget {
  final String buttonSuperior;
  final String titulo;
  final String linhaProd;
  final VoidCallback? onTap;

  const CabecalhoColaboradores({
    super.key,
    required this.buttonSuperior,
    required this.titulo,
    required this.linhaProd,
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
                Container(margin: EdgeInsets.only(top: 3, left: 15)),
                InkWell(
                  //DEVE SER SUBISTITUIDO POR LOGICAS E PUXAR OS ITENS REAIS DA LISTA.
                  onTap: onTap,
                  child: Text(
                    buttonSuperior,
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
                    'Informe os colaboradores envolvidos na produção',
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(4),
                  clipBehavior: Clip.antiAlias, // 🔑 recorta o splash
                  child: InkWell(
                    onTap: () {
                      print('logout clicado');
                      // Aqui você pode adicionar a lógica para realizar o logout
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.logout,
                        size: 23,
                        color: Colors.grey.shade700,
                      ),
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.person_outline,
                          size: 22,
                          color: NutribreadsColors.azulMedio,
                        ),
                      ),
                      Text(
                        linhaProd,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
