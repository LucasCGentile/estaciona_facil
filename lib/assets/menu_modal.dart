import 'package:flutter/material.dart';
import 'package:estaciona_facil/pages/login_page.dart';

class menu_modal extends StatelessWidget {
  const menu_modal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar e nome do usuário
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lucas Silva',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Lista de opções
          ListTile(
            leading: const Icon(Icons.wallet),
            title: const Text('Comprar Tickets'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Histórico de Uso'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Extrato'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text('Conta'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.text_snippet),
            title: const Text('Termos de Uso'),
            onTap: () {},
          ),

          const Spacer(),

          // Botão de sair
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 26.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Fecha o modal
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const login_page(title: 'Login'),
                      ),
                      (route) => false,
                    );
                  });
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sair do Aplicativo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
