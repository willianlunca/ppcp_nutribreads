import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/componentes/cabecalho_colaboradores.dart';

class Colaboradores extends StatefulWidget {
  const Colaboradores({super.key});

  @override
  State<Colaboradores> createState() => _ColaboradoresState();
}

class _ColaboradoresState extends State<Colaboradores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                CabecalhoColaboradores(
                  buttonSuperior: 'Bem-vindo!',
                  titulo: 'Equipe de Produção',
                  linhaProd: 'Equipe 01',
                ),
                Container(
                  width: 600,
                  height: 200,
                  decoration: BoxDecoration(color: Colors.amber),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
