import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_list_ordens.dart';
import 'package:ppcp_nutribreads/componentes/card_ordem.dart';
import 'package:ppcp_nutribreads/functions/loop.dart';

class ListaOrdens extends StatefulWidget {
  const ListaOrdens({super.key});

  @override
  State<ListaOrdens> createState() => _ListaOrdensState();
}

class _ListaOrdensState extends State<ListaOrdens> {
  @override
  void initState() {
    super.initState();

    DebugLoop.onTick = () {
      if (mounted) setState(() {});
    };

    DebugLoop.iniciar();
  }

  @override
  void dispose() {
    DebugLoop.parar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contador = DebugLoop.contador;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          Center(child: CabecalhoListOrdens(quantidade_pendente: 30)),
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0147',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 8,
                      qtdProduzidas: 3, // ✅ se quiser mudar também
                    ),
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0148',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 18,
                      qtdProduzidas: 2, // ✅ se quiser mudar também
                    ),
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0149',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 28,
                      qtdProduzidas: 16, // ✅ se quiser mudar também
                    ),
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0150',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 10,
                      qtdProduzidas: 9, // ✅ se quiser mudar também
                    ),
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0151',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 8,
                      qtdProduzidas: 3, // ✅ se quiser mudar também
                    ),
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0152',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 18,
                      qtdProduzidas: 2, // ✅ se quiser mudar também
                    ),
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0153',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 28,
                      qtdProduzidas: 16, // ✅ se quiser mudar também
                    ),
                    CardOrdem(
                      descricaoOrdem: 'OP-2026-0154',
                      prioridade: contador.toString(), // ✅ aqui
                      linhaProducao: 'Linha 02',
                      data: '02/02/2026',
                      qtdItens: 10,
                      qtdProduzidas: 9, // ✅ se quiser mudar também
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
