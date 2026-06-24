import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/componentes/load.dart';
import 'dart:ui';
import 'package:ppcp_nutribreads/componentes/modulos_cabecalho.dart';
import 'package:ppcp_nutribreads/componentes/modulos_card_modulos.dart';
import 'package:ppcp_nutribreads/componentes/ppcp_card_lista_colaboradores.dart';
import 'package:ppcp_nutribreads/screens/equipamentos.dart';
import 'package:ppcp_nutribreads/screens/manufatura.dart';
import 'package:ppcp_nutribreads/screens/screenLoad.dart';
import 'package:ppcp_nutribreads/services/api.dart';
import 'package:lottie/lottie.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:lottie/lottie.dart';

class Modulos extends StatefulWidget {
  const Modulos({super.key});

  @override
  State<Modulos> createState() => _ModulosState();
}

@override
class _ModulosState extends State<Modulos> {
  void initState() {
    _carregarPermissoes();
    super.initState();
  }

  Future<void> _carregarPermissoes() async {
    final dados = await PermissoesService().buscarPermissoes();

    if (!mounted) return;

    setState(() {
      permissoes = List<Map<String, dynamic>>.from(dados);

      if (permissoes.isNotEmpty) {
        comercial = permissoes[0]['comercial'] == true;
      } else {
        comercial = false;
      }

      carregando = false;
    });
  }

  bool convertPermissaoBoolean(String nome) {
    if (permissoes.isEmpty) return false;
    return permissoes[0][nome] == true;
  }

  bool temPermissao(String nomePermissao) {
    if (permissoes.isEmpty) return false;

    return permissoes[0][nomePermissao] == true;
  }

  @override
  List<Map<String, dynamic>> permissoes = [];
  bool carregando = true;
  bool comercial = false;

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
    //double tamanhoTexto = larguraCard * 0.10;
    //double tamanhoBox = larguraCard * 0.4;
    if (carregando) {
      return Scaffold(
        body: Center(
          child: Lottie.asset(
            'assets/animations/animacao_verde_escuro.json',
            width: 100,
            height: 100,
          ),
        ),
      );
      //return const LoadWidget();
      //return LoadWidget();
    }
    if (permissoes.isEmpty) {
      return const Scaffold(
        backgroundColor: BillhardColors.bege,
        body: Center(
          child: Text(
            'Você não tem permissão para acessar esse aplicativo',
            style: TextStyle(
              color: BillhardColors.verdePrincipal,
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: ModulosCabecalho(
                iniciaisNome: 'WL',
                nomeCompleto: 'Willian Lunca',
                cargo: 'Diretor',
                titulo: 'Selecione o Módulo',
              ),
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: NutribreadsColors.azulEscuro,
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));

                final dados = await PermissoesService().buscarPermissoes();

                if (!mounted) return;

                setState(() {
                  permissoes = List<Map<String, dynamic>>.from(dados);

                  if (permissoes.isNotEmpty) {
                    comercial = permissoes[0]['comercial'] ?? false;
                  } else {
                    comercial = false;
                  }
                });
              },
              child: Center(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    Column(
                      children: [
                        Wrap(
                          children: [
                            CardModulos(
                              icone: Icons.trending_up,
                              corIcone: Colors.blue.shade800,
                              corBloco: Colors.blue.shade100,
                              titulo: 'Comercial',
                              permissao:
                                  permissoes[0]['comercial'], //temPermissao('comercial'),
                              descricao: 'Vendas e CRM',
                              onTap: () {
                                load(context);
                                print('Comercial');
                              },
                            ),
                            CardModulos(
                              icone: Icons.bakery_dining,
                              corIcone: Colors.green.shade800,
                              corBloco: Colors.green.shade100,
                              titulo: 'Manufatura',
                              permissao: permissoes[0]['manufatura'],
                              descricao: 'Ingredientes e Receitas',
                              onTap: () {
                                load(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //builder: (context) => const Colaboradores(),
                                    builder: (context) => const Manufatura(),
                                  ),
                                );
                              },
                            ),
                            CardModulos(
                              icone: Icons.shopping_cart,
                              corIcone: Colors.amber.shade800,
                              corBloco: Colors.amber.shade100,
                              titulo: 'Compras',
                              permissao: permissoes[0]['compras'],
                              descricao: 'Compras e Estoque',
                            ),
                            CardModulos(
                              icone: Icons.local_shipping_outlined,
                              corIcone: Colors.grey.shade800,
                              corBloco: Colors.grey.shade300,
                              titulo: 'Logistica',
                              permissao: permissoes[0]['logistica'],
                              descricao: 'Logistica e Distribuição',
                            ),
                            CardModulos(
                              icone: Icons.construction,
                              corIcone: Colors.purple.shade800,
                              corBloco: Colors.purple.shade100,
                              titulo: 'Manutenção',
                              permissao: permissoes[0]['manutencao'],
                              descricao: 'Manutenção',
                            ),
                            CardModulos(
                              icone: Icons.factory,
                              corIcone: Colors.brown.shade800,
                              corBloco: Colors.brown.shade100,
                              titulo: 'PPCP',
                              permissao: permissoes[0]['ppcp'],
                              descricao: 'Controle da Produção',
                            ),
                            CardModulos(
                              icone: Icons.precision_manufacturing,
                              corIcone: Colors.teal.shade800,
                              corBloco: Colors.teal.shade100,
                              titulo: 'Equipamentos',
                              permissao: permissoes[0]['equipamentos'],
                              descricao: 'Controle da Equipamentos',
                              onTap: () {
                                load(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    //builder: (context) => const Colaboradores(),
                                    builder: (context) => const Equipamentos(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: alturaCard / 2,
            decoration: BoxDecoration(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}

/* 
ListView(
          children: [
            Column(
              children: [
                ModulosCabecalho(
                  titulo: 'Módulos',
                  onTap: () {
                    // Lógica para o botão superior
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Ink(
                        width: larguraCard,
                        height: alturaCard,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.brown.shade600,
                            // cor da borda
                            width: 0.8,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '+1',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
*/
