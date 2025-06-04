import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:estaciona_facil/assets/app_colors.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key, required this.title});

  final String title;

  @override
  State<TicketPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TicketPage> {
  String _metodoSelecionado = 'Pix';

  final List<String> _opcoesPagamento = [
    'Pix',
    'Cartão de crédito',
    'Cartão de débito',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Deseja adquirir um ticket? \nSelecione o valor abaixo:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.corPrincipal,
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1),
                    ),
                    child: Center(
                      child: Text(
                        'TOTAL (R\$)\n5,00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.corPrincipal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    backgroundColor: AppColors.corPrincipal,
                    child: Icon(Icons.remove, color: Colors.white, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Selecione a forma de pagamento:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),

              // Bloco com as opções de pagamento
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.corPrincipal, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: _opcoesPagamento.map((opcao) {
                    return RadioListTile<String>(
                      title: Text(opcao),
                      value: opcao,
                      groupValue: _metodoSelecionado,
                      activeColor: Colors.purple,
                      onChanged: (value) {
                        setState(() {
                          _metodoSelecionado = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
