import 'dart:async';
import 'package:estaciona_facil/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:estaciona_facil/assets/app_colors.dart';

bool mostrarSaldo = true;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Duration tempoRestante = Duration(minutes: 30); // Tempo inicial (ex: 30 min)
  Timer? timer;

  @override
  void initState() {
    super.initState();
    carregarTempo();
  }

  Future<void> carregarTempo() async {
    final prefs = await SharedPreferences.getInstance();
    int segundosSalvos =
        prefs.getInt('tempoRestante') ?? 1800; // 30 minutos padrão
    setState(() {
      tempoRestante = Duration(seconds: segundosSalvos);
    });
    iniciarContador();
  }

  void iniciarContador() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) async {
      if (tempoRestante.inSeconds <= 0) {
        timer?.cancel();
        return;
      }

      setState(() {
        tempoRestante -= Duration(seconds: 1);
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('tempoRestante', tempoRestante.inSeconds);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SALDO
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.corPrincipal,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: (0.7 * 255).round().toDouble(),
                    ),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
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
                    mostrarSaldo ? 'R\$ 24,00' : '••••••••',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),

            // AÇÕES
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  _botaoAcao(
                    icon: Icons.no_crash,
                    label: 'Estacionar Agora',
                    onPressed: () {},
                  ),

                  SizedBox(width: 12),

                  _botaoAcao(
                    icon: Icons.account_balance_wallet,
                    label: 'Adicionar Crédito',
                    onPressed: () {},
                  ),

                  SizedBox(width: 12),

                  _botaoAcao(
                    icon: Icons.history,
                    label: 'Histórico de Uso',
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // CONTADOR DE TEMPO
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tempo restante',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${tempoRestante.inHours.toString().padLeft(2, '0')}:'
                        '${tempoRestante.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
                        '${tempoRestante.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          MainScreenState.of(
                            context,
                          )?.setCurrentIndex(1); // Redireciona para TicketPage
                        },

                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          shadowColor: Colors.black.withValues(
                            alpha: (0.8 * 255).round().toDouble(),
                          ),
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
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ativar notificação de tempo limite',
                        style: TextStyle(fontSize: 16),
                      ),
                      Switch.adaptive(
                        value: true,
                        onChanged: (bool value) {
                          // Adicione aqui sua lógica de notificação
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // BANNER FINAL
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'e-Fácil São Roque, praticidade para estacionar!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://play-lh.googleusercontent.com/v6fXEV_ghjMDsKFxTRlN6z6bD8-GRUgCTqUiE-WdlrzkYyqGo-LPwtuLoHfC2WLZi14',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoAcao({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 8,
        shadowColor: Colors.black.withValues(
          alpha: (0.8 * 255).round().toDouble(),
        ),
        backgroundColor: Colors.grey[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.black, size: 32),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
