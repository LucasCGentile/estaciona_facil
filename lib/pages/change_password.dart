import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required String title});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _ocultarSenhaAtual = true;
  bool _ocultarNovaSenha = true;

  final TextEditingController _senhaAtualController = TextEditingController();
  final TextEditingController _novaSenhaController = TextEditingController();

  @override
  void dispose() {
    _senhaAtualController.dispose();
    _novaSenhaController.dispose();
    super.dispose();
  }

  void _mostrarAnimacaoLottie() {
    final senhaAtual = _senhaAtualController.text.trim();
    final novaSenha = _novaSenhaController.text.trim();

    if (senhaAtual.isEmpty || novaSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha ambos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (novaSenha.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A nova senha deve ter no mínimo 8 caracteres.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Lottie.network(
              'https://assets7.lottiefiles.com/packages/lf20_usmfx6bp.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha atualizada com sucesso!')),
      );

      _senhaAtualController.clear();
      _novaSenhaController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alterar Senha')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _senhaAtualController,
              obscureText: _ocultarSenhaAtual,
              decoration: InputDecoration(
                labelText: 'Senha Atual',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _ocultarSenhaAtual
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _ocultarSenhaAtual = !_ocultarSenhaAtual;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _novaSenhaController,
              obscureText: _ocultarNovaSenha,
              decoration: InputDecoration(
                labelText: 'Nova Senha',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _ocultarNovaSenha ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _ocultarNovaSenha = !_ocultarNovaSenha;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Dicas para uma senha segura:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• Use pelo menos 8 caracteres.'),
                  Text('• Inclua letras maiúsculas e minúsculas.'),
                  Text('• Adicione números e símbolos.'),
                  Text('• Evite senhas óbvias como "123456" ou "senha".'),
                  Text('• Não reutilize senhas antigas.'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _mostrarAnimacaoLottie,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.corPrincipal,
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
