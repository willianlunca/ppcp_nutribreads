import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lottie/lottie.dart';

class ResetSenha extends StatefulWidget {
  const ResetSenha({super.key});

  @override
  State<ResetSenha> createState() => _ResetSenhaState();
}

class _ResetSenhaState extends State<ResetSenha> {
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> recuperarSenha() async {
    final supa = Supabase.instance.client;

    try {
      await supa.auth.resetPasswordForEmail(
        emailController.text.trim(),
        redirectTo: 'https://billhard.com.br/recovery-pwd.html',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enviamos um e-mail para redefinir sua senha.'),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: ${e.message}')));
    } finally {
      if (!mounted) return;

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Login()));
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
    double tamanhoTexto = larguraTela * 0.10;

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
              height: alturaTela * 1.8,
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
                    child: Text(
                      'E-mail para recuperação de senha',
                      style: TextStyle(
                        fontSize: tamanhoTexto * 0.7,
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
                    margin: const EdgeInsets.only(top: 16),
                    width: double.infinity, // ocupa toda a largura
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
                                child: Lottie.asset(
                                  'assets/animations/animacao_azul_escuro.json',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            );
                          },
                        );

                        try {
                          await recuperarSenha();
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
                          Icon(Icons.lock_reset, size: 20, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Recuperar Senha',
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
                        print('pressionado botao entrar');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Login()),
                        );
                      },
                      child: Text(
                        'Voltar a tela de login?',
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
          ],
        ),
      ),
    );
  }
}
