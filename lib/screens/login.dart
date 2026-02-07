import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppcp_nutribreads/colors/colors.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                'assets/logo/Nutrib_v2.png',
                width: 200,
                height: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.60,
              height: 300,
              decoration: BoxDecoration(
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
                          'Matrícula',
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
                      selectionControls: CupertinoTextSelectionControls(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // 🔒 só 0–9
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 12,
                        ),
                        labelText: 'Matrícula',
                        hintText: 'Digite sua matrícula',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity, // ocupa toda a largura
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        // ação do login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NutribreadsColors.azulEscuro,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sua matriucula é atualizada constantemente',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
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
