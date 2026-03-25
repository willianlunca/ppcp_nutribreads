import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/componentes/ppcp_cabecalho_colaboradores.dart';
import 'package:ppcp_nutribreads/componentes/ppcp_card_lista_colaboradores.dart';
import 'package:ppcp_nutribreads/services/api.dart';
import 'dart:convert';

import 'package:ppcp_nutribreads/services/functions.dart';

class Colaboradores extends StatefulWidget {
  const Colaboradores({super.key});

  @override
  State<Colaboradores> createState() => _ColaboradoresState();
}

class _ColaboradoresState extends State<Colaboradores> {
  List<Map<String, dynamic>> lista = [];
  List<Map<String, dynamic>> colaboradoresSelecionados = [];
  bool carregando = false;

  Future<void> carregar() async {
    try {
      setState(() => carregando = true);

      final resultado = await carregarColaboradores();

      setState(() {
        lista = resultado;
        carregando = false;
      });
    } catch (e) {
      setState(() => carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            Center(
              child: Column(
                children: [
                  CabecalhoColaboradores(
                    buttonSuperior: 'Bem-vindo!',
                    titulo: 'Equipe de Produção',
                    linhaProd: 'Equipe 01',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),

                    child: Wrap(
                      spacing: 12,
                      children: colaboradoresSelecionados.map((colaborador) {
                        final nome = colaborador["nome"] ?? "";
                        final cargo = colaborador["cargo"] ?? "";

                        // pega iniciais automaticamente
                        final partes = nome.split(" ");
                        String iniciais = "";
                        if (partes.isNotEmpty) {
                          iniciais += partes[0][0];
                          if (partes.length > 1) {
                            iniciais += partes[1][0];
                          }
                        }

                        return CardListaColaboradores(
                          iniciaisNome: iniciais.toUpperCase(),
                          nomeCompleto: nome,
                          cargo: cargo,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person_add,
                              color: NutribreadsColors.azulMedio,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                'Adicionar Colaborador',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(),
                          child: Autocomplete<Map<String, dynamic>>(
                            optionsBuilder: (TextEditingValue value) {
                              final texto = value.text.trim().toLowerCase();

                              if (texto.isEmpty) {
                                return const Iterable<
                                  Map<String, dynamic>
                                >.empty();
                              }

                              final primeiraLetraDigitada = texto[0];

                              return lista.where((c) {
                                final nome = (c["nome"] ?? "")
                                    .toString()
                                    .toLowerCase();

                                if (nome.isEmpty) return false;

                                return nome[0] == primeiraLetraDigitada;
                              });
                            },

                            displayStringForOption: (option) => option["nome"],

                            onSelected: (option) {
                              setState(() {
                                colaboradoresSelecionados.add(option);
                              });
                            },

                            fieldViewBuilder:
                                (
                                  context,
                                  controller,
                                  focusNode,
                                  onFieldSubmitted,
                                ) {
                                  return TextField(
                                    controller: controller,
                                    focusNode: focusNode,

                                    onTap: () async {},
                                    decoration: InputDecoration(
                                      labelText: 'Buscar por nome',
                                      suffixIcon: carregando
                                          ? const Padding(
                                              padding: EdgeInsets.all(12),
                                              child: SizedBox(
                                                width: 18,
                                                height: 18,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            )
                                          : null,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: NutribreadsColors.azulMedio,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        //Inserir colaborador
                        /*await inserirColaborador(
                          nome: 'Eloisa Sanches',
                          cpf: '08186414959',
                          aniversario: DateTime(1992, 5, 12),
                        );*/

                        lista = await buscarColaboradores();
                        debugPrint('Quantidade de registros: ${lista.length}');

                        final jsonFormatado = const JsonEncoder.withIndent(
                          '  ',
                        ).convert(lista);

                        debugPrint(jsonFormatado);
                      } catch (e) {
                        debugPrint('ERRO: $e');
                      }
                    },
                    child: Text('Inserir Colaborador'),
                  ),
                ],
              ),
            ),
          ],
        ),

        onRefresh: () async {
          await carregar();
          print("Atualizando...");
        },
      ),
    );
  }
}
