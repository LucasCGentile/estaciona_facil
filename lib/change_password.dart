import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alterar Senha')),
      body: const Center(
        child: Text('Aqui vai o formulário para alterar senha'),
      ),
    );
  }
}
