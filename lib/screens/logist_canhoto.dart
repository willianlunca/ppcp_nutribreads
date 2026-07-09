import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:billhard_app/functions/permissoes.dart';

class LogistCanhoto extends StatefulWidget {
  const LogistCanhoto({super.key});

  @override
  State<LogistCanhoto> createState() => _LogistCanhotoState();
}

class _LogistCanhotoState extends State<LogistCanhoto> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _permissao = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 150),
              child: TextField(
                controller: _permissao,
                decoration: InputDecoration(labelText: 'Digite algo'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Permissoes.temPermissao(_permissao.text);
              },
              child: const Text('Canhoto'),
            ),
          ],
        ),
      ),
    );
  }
}
