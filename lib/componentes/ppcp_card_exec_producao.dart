import 'package:flutter/material.dart';

class CardExecProducao extends StatelessWidget {
  final VoidCallback onFinalizar;
  final VoidCallback? onPausar;
  final VoidCallback? onAdicionar01;
  final VoidCallback? onRemover01;
  final VoidCallback? onAdicionar05;
  final VoidCallback? onRemover05;
  final VoidCallback? onAdicionar10;
  final VoidCallback? onRemover10;
  final VoidCallback? onAdicionar50;
  final VoidCallback? onRemover50;
  final VoidCallback? onAdicionar100;
  final VoidCallback? onRemover100;

  const CardExecProducao({
    super.key,
    required this.onFinalizar,
    this.onPausar,
    this.onAdicionar01,
    this.onRemover01,
    this.onAdicionar05,
    this.onRemover05,
    this.onAdicionar10,
    this.onRemover10,
    this.onAdicionar50,
    this.onRemover50,
    this.onAdicionar100,
    this.onRemover100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 20),
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown.shade600, width: 1.0),
              color: Colors.brown.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Apontar Produção',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.brown.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onAdicionar01?.call();
                            },
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
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.brown.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onAdicionar05?.call();
                            },
                            child: Center(
                              child: Text(
                                '+5',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.brown.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onAdicionar10?.call();
                            },
                            child: Center(
                              child: Text(
                                '+10',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.brown.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onAdicionar50?.call();
                            },
                            child: Center(
                              child: Text(
                                '+50',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.brown.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onAdicionar100?.call();
                            },
                            child: Center(
                              child: Text(
                                '+100',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onRemover01?.call();
                            },
                            child: Center(
                              child: Text(
                                '-1',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onRemover05?.call();
                            },
                            child: Center(
                              child: Text(
                                '-5',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onRemover10?.call();
                            },
                            child: Center(
                              child: Text(
                                '-10',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onRemover50?.call();
                            },
                            child: Center(
                              child: Text(
                                '-50',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),

                        child: Ink(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.shade600,
                              // cor da borda
                              width: 0.8,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              onRemover100?.call();
                            },
                            child: Center(
                              child: Text(
                                '-100',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
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
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.93,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Botão Pausar Pressionado');
                      onPausar?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100, // cor do botão
                      foregroundColor: Colors.white, // cor do texto
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Colors.orange.shade400, // 🔥 borda aqui
                          width: 1.3,
                        ),
                      ),
                      elevation: 8,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pause,
                          size: 30,
                          color: Colors.orange.shade400,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            'Pausar',
                            style: TextStyle(color: Colors.orange.shade400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Botão Finalizar Pressionado');
                      onFinalizar();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100, // cor do botão
                      foregroundColor: Colors.white, // cor do texto
                      padding: const EdgeInsets.symmetric(
                        horizontal: 124,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Colors.red.shade400, // 🔥 borda aqui
                          width: 1.3,
                        ),
                      ),
                      elevation: 8,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.stop_outlined,
                          size: 30,
                          color: Colors.red.shade400,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            'Finalizar',
                            style: TextStyle(color: Colors.red.shade400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
