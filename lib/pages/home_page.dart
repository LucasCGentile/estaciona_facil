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
  Duration tempoRestante = Duration(minutes: 15);
  final Duration tempoTotalInicial = Duration(minutes: 15);
  Timer? timer;
  bool notificacaoAtiva = true;

  @override
  void initState() {
    super.initState();
    carregarTempo();
  }

  Future<void> carregarTempo() async {
    final prefs = await SharedPreferences.getInstance();
    int segundosSalvos =
        prefs.getInt('tempoRestante') ?? tempoTotalInicial.inSeconds;
    tempoRestante = Duration(
      seconds: segundosSalvos.clamp(0, tempoTotalInicial.inSeconds),
    );
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

  Color getProgressColor() {
    double progress = tempoRestante.inSeconds / tempoTotalInicial.inSeconds;
    if (progress > 0.5) return Colors.green;
    if (progress > 0.2) return Colors.orange;
    return Colors.red;
  }

  String formatarTempo(Duration duracao) {
    int horas = duracao.inHours;
    int minutos = duracao.inMinutes.remainder(60);
    int segundos = duracao.inSeconds.remainder(60);
    return '${horas.toString().padLeft(2, '0')}:'
        '${minutos.toString().padLeft(2, '0')}:'
        '${segundos.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double progresso = tempoRestante.inSeconds / tempoTotalInicial.inSeconds;

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
                    color: const Color.fromARGB(77, 0, 0, 0),
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
                    onPressed: () {
                      MainScreenState.of(context)?.setCurrentIndex(8);
                    },
                  ),
                  SizedBox(width: 12),
                  _botaoAcao(
                    icon: Icons.account_balance_wallet,
                    label: 'Adicionar Crédito',
                    onPressed: () {
                      MainScreenState.of(context)?.setCurrentIndex(1);
                    },
                  ),
                  SizedBox(width: 12),
                  _botaoAcao(
                    icon: Icons.history,
                    label: 'Histórico de Uso',
                    onPressed: () {
                      MainScreenState.of(context)?.setCurrentIndex(3);
                    },
                  ),
                ],
              ),
            ),

            // CONTADOR CIRCULAR MENOR E À ESQUERDA
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // CÍRCULO À ESQUERDA
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: progresso,
                          strokeWidth: 10,
                          valueColor: AlwaysStoppedAnimation(
                            getProgressColor(),
                          ),
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      Text(
                        formatarTempo(tempoRestante),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  // TEXTOS E BOTÕES À DIREITA
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tempo restante',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            MainScreenState.of(context)?.setCurrentIndex(1);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 8,
                            shadowColor: const Color.fromARGB(204, 0, 0, 0),
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
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Notificação de tempo limite',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Switch(
                              value: notificacaoAtiva,
                              activeColor: AppColors.corPrincipal,
                              onChanged: (bool value) {
                                setState(() {
                                  notificacaoAtiva = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // REGULARIZAÇÃO PENDENTE
            GestureDetector(
              onTap: () {
                MainScreenState.of(context)?.setCurrentIndex(10);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 36,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Há uma regularização pendente. Toque para resolver agora.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            // BANNER FINAL
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
                    child: Image.asset(
                      'lib/assets/img/logoSaoRoque.png',
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
        shadowColor: const Color.fromARGB(204, 0, 0, 0),
        backgroundColor: Colors.grey[300],
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
