import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';
/*
Future<void> load(BuildContext context) async {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Stack(
        children: [
          // 🔥 BLUR
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),

          // 🔲 MODAL
          Center(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/animacao_azul_escuro.json',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
  await Future.delayed(const Duration(seconds: 1));
}

*/

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

void load(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return Stack(
        children: [
          // 🔥 BLUR
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),

          // 🔲 MODAL
          Center(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/animacao_azul_escuro.json',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class Load extends StatelessWidget {
  const Load({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // FUNDO ESCURO + BLUR
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.black.withOpacity(0.2)),
        ),

        // ANIMAÇÃO CENTRAL
        Center(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/animations/animacao_azul_escuro.json',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
