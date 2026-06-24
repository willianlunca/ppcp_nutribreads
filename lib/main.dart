import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:ppcp_nutribreads/componentes/load.dart';
import 'package:ppcp_nutribreads/functions/loop.dart';
import 'package:ppcp_nutribreads/screens/screenLoad.dart';
import 'package:ppcp_nutribreads/screens/logist_canhoto.dart';
import 'package:ppcp_nutribreads/screens/modulos.dart';
import 'package:ppcp_nutribreads/screens/ppcp_colaboradores.dart';
import 'package:ppcp_nutribreads/screens/ppcp_lista_ordens.dart';
import 'package:ppcp_nutribreads/screens/logist_canhoto.dart';
import 'package:ppcp_nutribreads/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  Widget? destino;

  @override
  void initState() {
    super.initState();
    verificarLogin();
  }

  Future<void> verificarLogin() async {
    await Future.delayed(const Duration(seconds: 2)); // tempo da animação

    final session = Supabase.instance.client.auth.currentSession;

    if (!mounted) return;

    setState(() {
      destino = session != null ? const Modulos() : const Login();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (destino == null) {
      return Scaffold(
        body: Container(
          color: BillhardColors.bege,
          child: Center(
            child: Lottie.asset(
              'assets/animations/animacao_verde_escuro.json',
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
    }

    return destino!;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DebugLoop.iniciar();

  await Supabase.initialize(
    //url: 'https://api.nutribreads.com.br',
    url: 'https://api.nutribreads.com.br',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPCP Nutribreads',

      // 🌎 pt-BR
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(),
      home: const AuthCheck(),
      //home: const Login(),
      //home: const Colaboradores(),
      //home: const LogistCanhoto(),
      //home: const ListaOrdens(),
      //home: LoadWidget(),
    );
  }
}
