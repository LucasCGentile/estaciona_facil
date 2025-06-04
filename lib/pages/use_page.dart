import 'package:flutter/material.dart';

class UsePage extends StatefulWidget {
  const UsePage({super.key, required this.title});

  final String title;

  @override
  State<UsePage> createState() => _UsePageState();
}

class _UsePageState extends State<UsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTicket(
              valor: "R\$ 4,00",
              emissao: "10:20 29/03/2025",
              codigo: "00002",
              validade: "12:20 29/03/2025",
              tempo: "2 h : 0 m",
              placa: "ERF-1J36",
              cidade: "SÃO ROQUE",
            ),
            buildTicket(
              valor: "R\$ 2,00",
              emissao: "14:50 24/03/2025",
              codigo: "00001",
              validade: "15:50 24/03/2025",
              tempo: "1 h : 0 m",
              placa: "ERF-1J36",
              cidade: "SÃO ROQUE",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTicket({
    required String valor,
    required String emissao,
    required String codigo,
    required String validade,
    required String tempo,
    required String placa,
    required String cidade,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Faixa lateral roxa
          Container(
            width: 5,
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          // Conteúdo do ticket
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Emissão Ticket",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    valor,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  rowItem("Emissão:", emissao),
                  rowItem("Código:", codigo),
                  rowItem("Validade:", validade),
                  rowItem("Tempo Total:", tempo),
                  const Divider(height: 16),
                  rowItem("Placa:", placa, isBoldRight: true),
                  rowItem("Cidade:", cidade),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowItem(String label, String value, {bool isBoldRight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: isBoldRight ? const TextStyle(fontWeight: FontWeight.bold) : null,
          ),
        ],
      ),
    );
  }
}
