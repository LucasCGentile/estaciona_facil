import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:estaciona_facil/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//Adicional do Bottom Navigator
Widget buildNavItem({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 38, // Aumenta o tamanho do ícone
        onPressed: onPressed,
      ),
      Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

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
      //App Bar para o topo
      appBar: AppBar(
        backgroundColor: AppColors.corPrincipal,
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        title: Row(
          spacing: 12,
          children: [
            // Avatar
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: AppColors.corPrincipal,
                size: 28,
              ),
            ),
            // Campo de busca
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'O que você procura ?',
                    hintStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //Area de Conteudo Central
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
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

      //Bottom Navigator
      bottomNavigationBar: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.corPrincipal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(icon: Icons.home, label: 'Home', onPressed: () {}),
            buildNavItem(
              icon: Icons.account_balance_wallet,
              label: 'Saldo',
              onPressed: () {},
            ),
            buildNavItem(
              icon: Icons.directions_car,
              label: 'Veículos',
              onPressed: () {},
            ),

            // Botão Menu que abre modal bottom sheet
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white, size: 32),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      isScrollControlled: true,
                      builder:
                          (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar + nome
                                Center(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.deepPurple,
                                        child: Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Lucas Silva',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Itens do menu
                                ListTile(
                                  leading: Icon(Icons.wallet),
                                  title: Text('Comprar Tickets'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.history),
                                  title: Text('Histórico de Uso'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.account_balance),
                                  title: Text('Extrato'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.account_box),
                                  title: Text('Conta'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.settings),
                                  title: Text('Configurações'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Icons.text_snippet),
                                  title: Text('Termos de Uso'),
                                  onTap: () {},
                                ),

                                Spacer(), // empurra o botão para baixo
                                // Botão Sair
                                Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context); // Fecha o modal

                                      // Aguarda o modal fechar antes de navegar
                                      Future.delayed(
                                        Duration(milliseconds: 100),
                                        () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => login_page(
                                                    title: 'Home Page',
                                                  ),
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.logout),
                                    label: Text('Sair do Aplicativo'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[600],
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      textStyle: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                ),
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
