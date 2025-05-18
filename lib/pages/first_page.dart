import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:estaciona_facil/pages/login_page.dart';
import 'package:estaciona_facil/pages/register_process/register_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 68,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://play-lh.googleusercontent.com/v6fXEV_ghjMDsKFxTRlN6z6bD8-GRUgCTqUiE-WdlrzkYyqGo-LPwtuLoHfC2WLZi14',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              spacing: 13,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const login_page(title: 'Login'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corBotao,
                    foregroundColor: Colors.white,
                    fixedSize: Size(160, 50),
                    elevation:
                        8, // Altura da sombra (maior = sombra mais forte)
                    shadowColor: Colors.black,
                  ),
                  child: Text('Entrar', style: TextStyle(fontSize: 20)),
                ),

                Text(
                  'ou',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                const register_page(title: 'Cadastre-se'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corBotao,
                    foregroundColor: Colors.white,
                    fixedSize: Size(160, 50),
                    elevation:
                        8, // Altura da sombra (maior = sombra mais forte)
                    shadowColor: Colors.black,
                  ),
                  child: Text('Cadastrar', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
