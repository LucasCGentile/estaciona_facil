import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:estaciona_facil/pages/login_page.dart';
import 'package:flutter/material.dart';

class register_complete_page extends StatefulWidget {
  const register_complete_page({super.key, required this.title});

  final String title;

  @override
  State<register_complete_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<register_complete_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Texto Inicial
            Text(
              'Seja Bem - Vindo!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.corPrincipal,
              ),
            ),
            //Logo
            Padding(
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
            //Texto Final
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Cadastro concluído com sucesso!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.corPrincipal,
                ),
              ),
            ),
            //Botao para fazer o login
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login_page(title: 'Pagina de Login'),
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
              child: Text('Entrar', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
