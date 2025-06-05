import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:flutter/material.dart';

class EstacionaPage extends StatefulWidget {
  const EstacionaPage({super.key, required this.title});

  final String title;

  @override
  State<EstacionaPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EstacionaPage> {

  String? veiculoSelecionado;
  final List<String> veiculos = ['AHFIFHE5', 'AHFIFHE6', 'AHFIFHE7'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Você está em São Roque",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
          
              // Dropdown de veículos
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "selecione o veículo",
                ),
                value: veiculoSelecionado,
                items: veiculos
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    veiculoSelecionado = value;
                  });
                },
              ),
              const SizedBox(height: 20),
          
              // Cards de preço
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPrecoCard("R\$ 2,00", "1 hora"),
                  const SizedBox(width: 16),
                  buildPrecoCard("R\$ 4,00", "2 horas"),
                ],
              ),
              const SizedBox(height: 30),
          
              // Botão ADICIONAR
              ElevatedButton(
                onPressed: () {
                  // Ação do botão
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  AppColors.corPrincipal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text(
                  "ADICIONAR",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPrecoCard(String valor, String duracao) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.star, color: Colors.purple),
          const Divider(color: Colors.purple),
          Text(
            valor,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(duracao),
        ],
      
      
        ),
        );
  }
}
