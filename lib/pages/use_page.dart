import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UsePage extends StatefulWidget {
  const UsePage({super.key, required this.title});

  final String title;

  @override
  State<UsePage> createState() => _UsePageState();
}

class _UsePageState extends State<UsePage> {
  final double valorTicket = 4.00;

  final List<Map<String, dynamic>> tickets = [
    {
      "emissao": DateTime(2025, 3, 29, 10, 20),
      "duracao": Duration(hours: 2),
      "valor": 4.00,
      "codigo": "00002",
      "placa": "FWS-4E26",
    },
    {
      "emissao": DateTime(2025, 3, 24, 14, 50),
      "duracao": Duration(hours: 1),
      "valor": 2.00,
      "codigo": "00001",
      "placa": "FWS-4E26",
    },
    {
      "emissao": DateTime(2025, 3, 20, 9, 30),
      "duracao": Duration(hours: 2),
      "valor": 4.00,
      "codigo": "00000",
      "placa": "FWS-4E26",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
              tickets.map((ticket) {
                final emissao = ticket["emissao"] as DateTime;
                final validade = emissao.add(ticket["duracao"] as Duration);
                final tempo = validade.difference(emissao);
                final horas = tempo.inHours;
                final minutos = tempo.inMinutes.remainder(60);

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
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Emissão Ticket",
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
                                "Emissão:",
                                DateFormat('HH:mm dd/MM/yyyy').format(emissao),
                              ),
                              buildInfoRow("Código:", ticket["codigo"]),
                              buildInfoRow(
                                "Validade:",
                                DateFormat('HH:mm dd/MM/yyyy').format(validade),
                              ),
                              buildInfoRow(
                                "Tempo Total:",
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
}
