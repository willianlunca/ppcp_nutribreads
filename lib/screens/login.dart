import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:ppcp_nutribreads/screens/modulos.dart';
import 'package:ppcp_nutribreads/screens/ppcp_colaboradores.dart';
import 'package:ppcp_nutribreads/screens/ppcp_lista_ordens.dart';
import 'package:ppcp_nutribreads/screens/reset_senha.dart';
import 'package:ppcp_nutribreads/services/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final session = Supabase.instance.client.auth.currentSession;
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
            Container(
              height: 120,
              margin: EdgeInsets.only(top: 10),
              child: Image.asset(
                'assets/logo/billhard-versao-3.png',
                width: larguraTela * 1.7,

                //height: alturaTela,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.90,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 2.0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Text(
                          'Credenciais de acesso',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: TextField(
                      autofillHints: const [
                        AutofillHints.username,
                        AutofillHints.email,
                      ],
                      controller: emailController,
                      selectionControls: CupertinoTextSelectionControls(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                    margin: EdgeInsets.only(top: 8),
                    child: TextField(
                      autofillHints: const [AutofillHints.password],
                      controller: senhaController,
                      obscureText: true,
                      obscuringCharacter: '•',
                      selectionControls: CupertinoTextSelectionControls(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity, // ocupa toda a largura
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        final email = emailController.text.trim();
                        final senha = senhaController.text;
                        if (email.isEmpty || senha.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Preencha e-mail e senha'),
                            ),
                          );
                          return;
                        }

                        try {
                          final response = await _auth.signIn(
                            email: email,
                            password: senha,
                          );

                          if (response.user != null) {
                            // login OK
                            print('Usuário logado: ${response.user!.email}');
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Lottie.asset(
                                      'assets/animations/animacao_azul_escuro.json',
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                );
                              },
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (context) => const Colaboradores(),
                                builder: (context) => const Modulos(),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao logar: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: BillhardColors.terraCota,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.login, size: 20, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Entrar',
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
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            print('esqueci minha senha clicado');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResetSenha(),
                              ),
                            );
                          },
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
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
