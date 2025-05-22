import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:estaciona_facil/pages/main_screen.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  const login_page({super.key, required this.title});

  final String title;

  @override
  State<login_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.corPrincipal,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120.0),
          child: Center(
            child: Column(
              spacing: 48,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Seja Bem-Vindo!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                Container(
                  width: 370,
                  height: 280,
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
                  child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Digite seu E-mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.mail),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Digite sua Senha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
