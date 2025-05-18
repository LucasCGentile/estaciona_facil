import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:estaciona_facil/pages/register_process/register_complete_page.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class auth_page extends StatefulWidget {
  const auth_page({super.key, required this.title});

  final String title;

  @override
  State<auth_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<auth_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.corPrincipal,
      body: Center(
        child: Column(
          spacing: 28,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Area com a logo
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFF5EEEE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://play-lh.googleusercontent.com/v6fXEV_ghjMDsKFxTRlN6z6bD8-GRUgCTqUiE-WdlrzkYyqGo-LPwtuLoHfC2WLZi14',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),

            //Area Texto
            Column(
              children: [
                Text(
                  'Autenticação',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Um codigo foi enviado para o email informado!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //Area para inclusao dos codigo enviado
            Container(
              width: 370,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFF5EEEE),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 8),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PinCodeTextField(
                      appContext: context,
                      length: 5,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 60,
                        fieldWidth: 50,
                        activeColor: Colors.blue,
                        selectedColor: Colors.orange,
                        inactiveColor: Colors.grey,
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => register_complete_page(
                                  title: 'Cadastro Finalziado',
                                ),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.corBotao,
                        foregroundColor: Colors.white,
                        fixedSize: Size(160, 50),
                        elevation: 8,
                        shadowColor: Colors.black,
                      ),
                      child: Text('Validar', style: TextStyle(fontSize: 20)),
                    ),

                    //Solicitar um novo codigo
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Enviar outro Codigo',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
