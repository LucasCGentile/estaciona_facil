import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:estaciona_facil/pages/register_process/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final cpfMask = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {"#": RegExp(r'[0-9]')},
);

final telefoneMask = MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: {"#": RegExp(r'[0-9]')},
);

class register_page extends StatefulWidget {
  const register_page({super.key, required this.title});

  final String title;

  @override
  State<register_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<register_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.corPrincipal,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 80.0),
          child: Center(
            child: Column(
              spacing: 12,
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

                Column(
                  children: [
                    //Area dos textos
                    Text(
                      'Crie sua Conta',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Informe seus dados para prosseguir',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                //Area para inclusao dos dados
                Container(
                  width: 370,
                  height: 440,
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

                  //Box Nome
                  child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),

                      //Box CPF
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 14,
                          inputFormatters: [
                            cpfMask, // Permite apenas números
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: 'CPF',
                            hintText: '000.000.000-00',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.credit_card),
                          ),
                        ),
                      ),

                      //Box Telefone
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [telefoneMask],
                          decoration: InputDecoration(
                            labelText: 'Telefone',
                            hintText: '(11) 91234-5678',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                      ),

                      //Box Email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'seunome@email.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.mail),
                          ),
                        ),
                      ),

                      //Box Senha
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 0.0,
                          bottom: 12.0,
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                      ),

                      //Botao p/ continuar
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const auth_page(title: 'Authentication'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.corBotao,
                          foregroundColor: Colors.white,
                          fixedSize: Size(160, 50),
                          elevation: 8,
                          shadowColor: Colors.black,
                        ),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 20),
                        ),
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
