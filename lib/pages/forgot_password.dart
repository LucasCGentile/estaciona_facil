import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, required this.title});

  final String title;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendRecovery() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Por favor, insira seu e-mail')));
      return;
    }

    // Aqui você pode adicionar a lógica para enviar o e-mail de recuperação

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Link de recuperação enviado para $email')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.corPrincipal,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Recuperar Senha',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32),

                Container(
                  width: 370,
                  height: 220,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Digite seu E-mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.mail),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: _sendRecovery,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.corBotao,
                          foregroundColor: Colors.white,
                          fixedSize: Size(160, 50),
                          elevation: 8,
                          shadowColor: Colors.black,
                        ),
                        child: Text('Enviar', style: TextStyle(fontSize: 20)),
                      ),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Voltar ao Login',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.corPrincipal,
                          ),
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
