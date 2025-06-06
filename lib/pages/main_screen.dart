import 'package:estaciona_facil/assets/bottom_navigation.dart';
import 'package:estaciona_facil/assets/menu_modal.dart';
import 'package:estaciona_facil/pages/change_password.dart';
import 'package:estaciona_facil/pages/config_page.dart';
import 'package:estaciona_facil/pages/estaciona_page.dart';
import 'package:estaciona_facil/pages/home_page.dart';
import 'package:estaciona_facil/pages/my_account.dart';
import 'package:estaciona_facil/pages/receipt_page.dart';
import 'package:estaciona_facil/pages/terms_page.dart';
import 'package:estaciona_facil/pages/ticket_page.dart';
import 'package:estaciona_facil/pages/use_page.dart';
import 'package:estaciona_facil/pages/vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:estaciona_facil/assets/app_colors.dart';

// AppBar modularizada
PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.corPrincipal,
    automaticallyImplyLeading: false,
    toolbarHeight: 75,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
    ),
    title: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.person, color: AppColors.corPrincipal, size: 28),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder:
                    (context) => Container(
                      padding: const EdgeInsets.all(16),
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Informações do Usuário',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                    ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'O que você procura ?',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// MainScreen
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static MainScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainScreenState>();
  }

  final List<Widget> _pages = [
    const HomePage(title: 'Página Inicial'), // 0
    const TicketPage(title: 'Comprar Ticket'), // 1
    const VehiclePage(title: 'Meus Veículos'), // 2
    const UsePage(title: 'Histórico de Uso'), // 3
    const ReceiptPage(title: 'Extrato'), // 4
    const MyAccount(title: 'Minha Conta'), // 5
    const ConfigPage(title: 'Configurações'), // 6
    const TermsPage(title: 'Termos de Uso'), // 7
    const EstacionaPage(title: 'Estacionar agora'), // 8
    const ChangePassword(title: 'Alterar Senha'), // 9
  ];

  void _onNavTap(int index) {
    if (index == 3) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        isScrollControlled: true,
        builder:
            (_) => MenuModal(
              onPageSelected: (int pageIndex) {
                setState(() {
                  _currentIndex = pageIndex;
                });
              },
            ),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
