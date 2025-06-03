import 'package:estaciona_facil/change_password.dart';
import 'package:flutter/material.dart';
import 'package:estaciona_facil/pages/my_account.dart';
import 'package:estaciona_facil/pages/first_page.dart';

class AvatarModal extends StatelessWidget {
  const AvatarModal({super.key});

  Widget buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 16),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Informações do Usuário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          buildMenuButton(
            context: context,
            icon: Icons.password,
            label: 'Alterar Senha',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChangePassword(title: 'Alterar Senha'),
                ),
              );
            },
          ),

          buildMenuButton(
            context: context,
            icon: Icons.account_box,
            label: 'Editar Dados',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyAccount(title: 'Minha Conta'),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Apagar Conta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FirstPage(title: 'Início'),
                  ),
                  (route) => false,
                );
              },
            ),
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
