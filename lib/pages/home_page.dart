import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:estaciona_facil/assets/avatar_modal.dart';
import 'package:estaciona_facil/assets/bottom_navigation.dart';
import 'package:estaciona_facil/assets/menu_modal.dart';
import 'package:estaciona_facil/pages/ticket_page.dart';
import 'package:estaciona_facil/assets/app_bar.dart';
import 'package:estaciona_facil/pages/vehicle_page.dart';
import 'package:flutter/material.dart';

//Oculta/Mostra Saldo
bool mostrarSaldo = true;

class home_page extends StatefulWidget {
  const home_page({super.key, required this.title});

  final String title;

  @override
  State<home_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    //Area Scalfold
    return Scaffold(
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
      //Area de Conteudo Central
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 22.0),
        child: Center(
          child: Column(
            spacing: 24,
            children: [
              //Container Saldo
              Container(
                height: 120,
                width: 400,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.corPrincipal,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.7,
                      ), // cor da sombra com opacidade
                      spreadRadius: 0, // quanto a sombra se espalha
                      blurRadius: 8, // quão desfocada a sombra fica
                      offset: Offset(0, 4), // deslocamento da sombra (x, y)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saldo Disponível',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            mostrarSaldo
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              mostrarSaldo = !mostrarSaldo;
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      mostrarSaldo ? 'R\$ 24,67' : '••••••••',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),

              //Linha Botoes
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    spacing: 18,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Botão: Comprar Cupom
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 8, // intensidade
                          shadowColor: Colors.black.withOpacity(0.6),
                          backgroundColor: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                        ),
                        child: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.confirmation_num,
                              color: Colors.black,
                              size: 32,
                            ),
                            Text(
                              'Comprar Cupom',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botão: Adicionar Crédito
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 8, // intensidade
                          shadowColor: Colors.black.withOpacity(0.6),
                          backgroundColor: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                        ),
                        child: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: Colors.black,
                              size: 32,
                            ),
                            Text(
                              'Adicionar Crédito',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botão: Histórico de Uso
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 8, // intensidade
                          shadowColor: Colors.black.withOpacity(0.6),
                          backgroundColor: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                        ),
                        child: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history, color: Colors.black, size: 32),
                            Text(
                              'Histórico de Uso',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Area Tempo Restante
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Texto no topo esquerdo
                    Text(
                      'Tempo restante',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Row com contador decrescente e botão "Estender Tempo"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '00:23:17', // Aqui você deve colocar o valor do contador dinâmico
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 8, // intensidade
                            shadowColor: Colors.black.withOpacity(0.8),
                            backgroundColor: AppColors.corPrincipal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Estender Tempo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    // Switch estilo iOS com texto ao lado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ativar notificação de tempo limite',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch.adaptive(
                          value: true, // Substitua pelo estado real
                          onChanged: (bool value) {
                            // Lógica para habilitar/desabilitar notificação
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Area com Banner
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Fundo cinza
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Raio das bordas arredondadas
                ),
                padding: EdgeInsets.all(8), // fundo cinza claro
                child: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'e-Fácil São Roque, praticidade para estacionar!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Logo carregada via URL
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://play-lh.googleusercontent.com/v6fXEV_ghjMDsKFxTRlN6z6bD8-GRUgCTqUiE-WdlrzkYyqGo-LPwtuLoHfC2WLZi14',
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //Widget Bottom Navigation
      bottomNavigationBar: bottom_navigation(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Já está na Home, pode só ignorar
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
