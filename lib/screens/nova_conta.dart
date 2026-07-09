import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:billhard_app/colors/colors.dart';
import 'package:billhard_app/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lottie/lottie.dart';

class NovaConta extends StatefulWidget {
  const NovaConta({super.key});

  @override
  State<NovaConta> createState() => _NovaContaState();
}

class _NovaContaState extends State<NovaConta> {
  late final TextEditingController emailController;
  late final TextEditingController senhaController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    senhaController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> criarConta() async {
    final supa = Supabase.instance.client;

    try {
      await supa.auth.signUp(
        email: emailController.text.trim(),
        password: senhaController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso. Verifique seu e-mail.'),
        ),
      );

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Login()));
    } on AuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: ${e.message}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;

    int colunas = largura >= 1200
        ? 5
        : largura >= 900
        ? 4
        : largura >= 600
        ? 3
        : largura >= 400
        ? 2
        : 1;

    double larguraTela = (largura / colunas) - 40;
    double alturaTela = larguraTela * 0.9;

    return Scaffold(
      backgroundColor: BillhardColors.verdePrincipal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/billhard-versao-3.png',
              width: larguraTela * 2,
            ),

            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.90,
              height: alturaTela * 2.3,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 2.0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 25),
                    child: const Text(
                      'Criar conta',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextField(
                      controller: emailController,
                      selectionControls: CupertinoTextSelectionControls(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        labelText: 'E-mail',
                        hintText: 'Digite seu e-mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextField(
                      controller: senhaController,
                      obscureText: true,
                      selectionControls: CupertinoTextSelectionControls(),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          barrierColor: Colors.white,
                          pageBuilder: (_, __, ___) {
                            return Scaffold(
                              backgroundColor: Colors.white,
                              body: Center(
                                child: Container(
                                  color: BillhardColors.bege,
                                  child: Center(
                                    child: Lottie.asset(
                                      'assets/animations/animacao_verde_escuro.json',
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        try {
                          await criarConta();
                        } finally {
                          if (mounted) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BillhardColors.terraCota,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add, size: 20, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Criar Conta',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Login()),
                        );
                      },
                      child: const Text(
                        'Voltar para tela de login',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                '© 2024 Billhard. Todos os direitos reservados.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: BillhardColors.verdeSecundario,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
