import 'package:flutter/material.dart';
import 'package:billhard_app/componentes/load.dart';

class LoadWidget extends StatelessWidget {
  const LoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.transparent, body: Load());
  }
}
