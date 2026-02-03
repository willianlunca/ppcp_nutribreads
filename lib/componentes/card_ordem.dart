import 'package:flutter/material.dart';

class CardOrdem extends StatelessWidget {
  final String descricaoOrdem;
  final String prioridade;
  final String linhaProducao;
  final String data;
  final int qtdItens;
  final int qtdProduzidas;

  const CardOrdem({
    super.key,
    required this.descricaoOrdem,
    required this.prioridade,
    required this.linhaProducao,
    required this.data,
    required this.qtdItens,
    required this.qtdProduzidas,
  });

  double get progresso {
    if (qtdItens == 0) return 0.0;
    return qtdProduzidas / qtdItens;
  }

  String get descPrioridade {
    switch (prioridade) {
      case '1':
        return 'Alta';
      case '2':
        return 'Média';
      case '3':
        return 'Baixa';
    }
    return 'Erro';
  }

  Color get corPrioridade {
    switch (prioridade) {
      case '1':
        return Colors.red.shade50;
      case '2':
        return Colors.yellow.shade300;
      case '3':
        return Colors.grey.shade50;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(8);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ), // Obrigatorio para o uso do Padding

      child: Material(
        borderRadius: radius,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias, // recorta o ripple
        child: InkWell(
          borderRadius: radius,
          onTap: () => print('Card Ordem $descricaoOrdem pressionado'),
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.60,
            height: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.description,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                    Text(
                      descricaoOrdem,
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center, // 🔑 centraliza tudo
                      width: 60,
                      height: 25,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: corPrioridade,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        descPrioridade,
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      child: Text(
                        '$qtdItens Itens',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14),
                      child: Text(
                        linhaProducao,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14),
                      child: Text(
                        data,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: 14),
                      child: Icon(
                        Icons.chevron_right,
                        size: 28,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  margin: EdgeInsets.only(top: 10),
                  child: LinearProgressIndicator(
                    value: progresso,
                    backgroundColor: Colors.grey.shade300,
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
