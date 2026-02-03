import 'package:flutter/material.dart';

class CardProduto extends StatelessWidget {
  final String titulo;
  final String quantidade;
  final String status;
  final int quantidadeProduzida;
  final VoidCallback? onTap;

  const CardProduto({
    super.key,
    required this.titulo,
    required this.quantidade,
    required this.status,
    required this.quantidadeProduzida,
    this.onTap,
  });
  double get progresso {
    final total = int.tryParse(quantidade) ?? 0;
    if (total == 0) return 0.0;
    return quantidadeProduzida / total;
  }

  String get quantidadeTexto {
    return '$quantidadeProduzida / $quantidade un';
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(8);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6), // era margin
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias, // recorta o ripple
        child: InkWell(
          borderRadius: radius,
          onTap: onTap ?? () => print('Botão Produção pressionado'),
          child: Ink(
            // 🔑 Ink + decoração = splash certinho por dentro
            width: MediaQuery.of(context).size.width * 0.60,
            height: 150,

            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: Icon(
                        Icons.inventory_2,
                        size: 20,
                        color: Colors.indigo.shade900,
                      ),
                    ),

                    const SizedBox(width: 8),
                    SizedBox(
                      child: Text(
                        titulo,
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: SizedBox(
                        child: Text(
                          '$quantidadeProduzida / $quantidade un',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6, left: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center, // 🔑 centraliza tudo
                      width: 80,
                      height: 25,
                      child: Text(status, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  margin: EdgeInsets.only(top: 10),
                  child: LinearProgressIndicator(
                    value: progresso,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
