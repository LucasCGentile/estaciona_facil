import 'package:flutter/material.dart';

class avatar_modal extends StatelessWidget {
  const avatar_modal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Informações do Usuário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.password),
            title: Text('Alterar Senha'),
          ),
          const ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar Dados'),
          ),
          const ListTile(
            leading: Icon(Icons.delete),
            title: Text('Apagar Conta'),
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }
}
