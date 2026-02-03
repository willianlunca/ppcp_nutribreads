import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/screens/lista_ordens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPCP Nutribreads',
      theme: ThemeData(),
      home: const ListaOrdens(), // 👈 SUA TELA INICIAL
    );
  }
}
