import 'package:flutter/material.dart';
import 'package:estaciona_facil/pages/login_page.dart';

class MenuModal extends StatelessWidget {
  final void Function(int) onPageSelected;

  const MenuModal({super.key, required this.onPageSelected});

  Widget buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int pageIndex,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // Fecha o modal primeiro
        Future.delayed(const Duration(milliseconds: 150), () {
          onPageSelected(pageIndex);
        });
      },
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
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar e nome
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Lucas Silva',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Botões, agora usando índices da MainScreen
          buildMenuButton(
            context: context,
            icon: Icons.wallet,
            label: 'Comprar Tickets',
            pageIndex: 1, // índice da página TicketPage
          ),
          buildMenuButton(
            context: context,
            icon: Icons.history,
            label: 'Histórico de Uso',
            pageIndex: 3,
          ),
          buildMenuButton(
            context: context,
            icon: Icons.account_balance,
            label: 'Extrato',
            pageIndex: 4,
          ),
          buildMenuButton(
            context: context,
            icon: Icons.account_box,
            label: 'Conta',
            pageIndex: 5,
          ),
          buildMenuButton(
            context: context,
            icon: Icons.settings,
            label: 'Configurações',
            pageIndex: 6,
          ),
          buildMenuButton(
            context: context,
            icon: Icons.text_snippet,
            label: 'Termos de Uso',
            pageIndex: 7,
          ),
          buildMenuButton(
            context: context,
            icon: Icons.password,
            label: 'Alterar Senha',
            pageIndex: 8,
          ),

          const Spacer(),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 150), () {
                    if (!context.mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(title: 'Login'),
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
