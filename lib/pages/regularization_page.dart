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
      "valor": 4.00,
      "situacao": "Pendente",
      "placa": "FWS-4E26",
    },
    {
      "dataMulta": DateTime(2025, 3, 24, 14, 50),
      "duracao": Duration(hours: 1),
      "valor": 2.00,
      "situacao": "Regularizada",
      "placa": "FWS-4E26",
    },
    {
      "dataMulta": DateTime(2025, 3, 20, 9, 30),
      "duracao": Duration(hours: 2),
      "valor": 4.00,
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
          children: tickets.map((ticket) {
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
                              buildInfoRow("Data da Multa:",
                                  DateFormat('HH:mm dd/MM/yyyy').format(dataMulta)),
                              buildInfoRow("Situação:", situacao, boldValue: true),
                              buildInfoRow("Validade:",
                                  DateFormat('HH:mm dd/MM/yyyy').format(validade)),
                              buildInfoRow("Tempo de:", "$horas h : $minutos m"),
                              const Divider(height: 32),
                              buildInfoRow("Placa:", ticket["placa"], boldValue: true),
                              buildInfoRow("Cidade:", "SÃO ROQUE", boldValue: true),
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
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                ),
                                child: const Text("Pagar"),
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
                boldValue ? const TextStyle(fontWeight: FontWeight.bold) : const TextStyle(),
          ),
        ],
      ),
    );
  }

  void _showPagamentoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Escolha a forma de pagamento", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showPixModal(context);
                },
                child: const Text("PIX"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showCartaoModal(context);
                },
                child: const Text("Cartão de Crédito"),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Fechar"),
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
      builder: (ctx) => AlertDialog(
        title: const Text("Pagamento via PIX"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Escaneie o QR Code abaixo para efetuar o pagamento:"),
            const SizedBox(height: 16),
            Container(
              width: 150,
              height: 150,
              color: Colors.grey[300],
              child: const Center(child: Text("QR CODE")),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void _showCartaoModal(BuildContext context) {
    final TextEditingController numero = TextEditingController();
    final TextEditingController validade = TextEditingController();
    final TextEditingController cvv = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Pagamento com Cartão"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: numero,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Número do Cartão"),
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showConfirmacaoModal(context);
            },
            child: const Text("Próximo"),
          ),
        ],
      ),
    );
  }

  void _showConfirmacaoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Pagamento Concluído"),
        content: const Text("Seu pagamento foi realizado com sucesso."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
