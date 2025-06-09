import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegularizationPage extends StatefulWidget {
  const RegularizationPage({super.key, required this.title});

  final String title;

  @override
  State<RegularizationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegularizationPage> {
  final double valorTicket = 4.00;

  final List<Map<String, dynamic>> tickets = [
    {
      "dataMulta": DateTime(2025, 3, 29, 10, 20),
      "duracao": Duration(hours: 2),
      "valor": 10.00,
      "situacao": "Pendente",
      "placa": "FWS-4E26",
    },
    {
      "dataMulta": DateTime(2025, 3, 24, 14, 50),
      "duracao": Duration(hours: 1),
      "valor": 10.00,
      "situacao": "Regularizada",
      "placa": "FWS-4E26",
    },
    {
      "dataMulta": DateTime(2025, 3, 20, 9, 30),
      "duracao": Duration(hours: 2),
      "valor": 10.00,
      "situacao": "Vencida",
      "placa": "FWS-4E26",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
              tickets.map((ticket) {
                final dataMulta = ticket["dataMulta"] as DateTime;
                final validade = dataMulta.add(ticket["duracao"] as Duration);
                final tempo = validade.difference(dataMulta);
                final horas = tempo.inHours;
                final minutos = tempo.inMinutes.remainder(60);
                final situacao = ticket["situacao"];

                Color borderColor;
                switch (situacao) {
                  case "Regularizada":
                    borderColor = Colors.green;
                    break;
                  case "Pendente":
                    borderColor = Colors.amber;
                    break;
                  default:
                    borderColor = Colors.red;
                }

                return Container(
                  height: 280,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Valor da Multa",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "R\$ ${ticket["valor"].toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  buildInfoRow(
                                    "Data da Multa:",
                                    DateFormat(
                                      'HH:mm dd/MM/yyyy',
                                    ).format(dataMulta),
                                  ),
                                  buildInfoRow(
                                    "Situação:",
                                    situacao,
                                    boldValue: true,
                                  ),
                                  buildInfoRow(
                                    "Validade:",
                                    DateFormat(
                                      'HH:mm dd/MM/yyyy',
                                    ).format(validade),
                                  ),
                                  buildInfoRow(
                                    "Tempo de:",
                                    "$horas h : $minutos m",
                                  ),
                                  const Divider(height: 32),
                                  buildInfoRow(
                                    "Placa:",
                                    ticket["placa"],
                                    boldValue: true,
                                  ),
                                  buildInfoRow(
                                    "Cidade:",
                                    "SÃO ROQUE",
                                    boldValue: true,
                                  ),
                                ],
                              ),
                              if (situacao == "Pendente")
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _showPagamentoModal(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow[700],
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                    ),
                                    child: const Text(
                                      "Pagar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value, {bool boldValue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style:
                boldValue
                    ? const TextStyle(fontWeight: FontWeight.bold)
                    : const TextStyle(),
          ),
        ],
      ),
    );
  }

  void _showPagamentoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity, // largura total
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              const Text(
                "Escolha a forma de pagamento",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showPixModal(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corPrincipal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                child: const Text("PIX", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showCartaoModal(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corPrincipal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                child: const Text("Cartão de Crédito", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            
              TextButton(
                onPressed: () {
                  Navigator.of(context).maybePop(); // mais seguro
                },
                child: const Text(
                  "Fechar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPixModal(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("Pagamento via PIX"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Escaneie o QR Code abaixo para efetuar o pagamento:",
                ),
                const SizedBox(height: 16),
                Image.asset(
                  'lib/assets/img/qrcode.jpeg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.corBotao,
                ),
                child: const Text(
                  "Fechar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showCartaoModal(BuildContext context) {
    final numero = TextEditingController();
    final validade = TextEditingController();
    final cvv = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Pagamento com Cartão"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: numero,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Número do Cartão",
                      ),
                    ),
                    TextField(
                      controller: validade,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(labelText: "Validade"),
                    ),
                    TextField(
                      controller: cvv,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "CVV"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                  child: const Text(
                    "Fechar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showConfirmacaoModal(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corBotao, // cor do botão
                  ),
                  child: const Text(
                    "Próximo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showConfirmacaoModal(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            icon: const Icon(Icons.check_circle, color: Colors.green, size: 50),
            title: const Text("Pagamento Concluído"),
            content: const Text("Seu pagamento foi realizado com sucesso."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // Usa o contexto do AlertDialog
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
}
