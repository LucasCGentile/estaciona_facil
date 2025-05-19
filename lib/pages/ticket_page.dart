import 'package:estaciona_facil/assets/app_bar.dart';
import 'package:estaciona_facil/assets/avatar_modal.dart';
import 'package:estaciona_facil/assets/bottom_navigation.dart';
import 'package:estaciona_facil/assets/menu_modal.dart';
import 'package:estaciona_facil/pages/vehicle_page.dart';
import 'package:estaciona_facil/pages/home_page.dart';
import 'package:flutter/material.dart';

class ticket_page extends StatefulWidget {
  const ticket_page({super.key, required this.title});

  final String title;

  @override
  State<ticket_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ticket_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Widget AppBar
      appBar: app_bar(
        onAvatarTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) => const avatar_modal(),
          );
        },
        hintText: 'Buscar Ticket...',
      ),

      body: Center(child: Text('pagina tickets')),

      //Widget Bottom Navigation
      bottomNavigationBar: bottom_navigation(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const home_page(title: 'Pagina Inicial'),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ticket_page(title: 'Comprar Ticket'),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const vehicle_page(title: 'Meus Veiculos'),
                ),
              );
              break;
            case 3:
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                isScrollControlled: true,
                builder: (_) => menu_modal(), // seu widget modal
              );
              break;
          }
        },
      ),
    );
  }
}
