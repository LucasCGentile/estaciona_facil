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
  final List<String> veiculos = ['FWS4E26', 'ETE-4527'];
  String _metodoSelecionado = 'Saldo da Conta';

  final List<String> _opcoesPagamento = [
    'Saldo da Conta',
    'Pix',
    'Cartão de crédito',
  ];

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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Selecione um veículo",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPrecoCard("R\$ 2,00", "1 hora"),
                  const SizedBox(width: 16),
                  buildPrecoCard("R\$ 4,00", "2 horas"),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _mostrarModalPagamentoInicial,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.corPrincipal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  "ADICIONAR",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
          const Icon(Icons.star, color: AppColors.corPrincipal),
          const Divider(color: AppColors.corPrincipal),
          Text(
            valor,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(duracao),
        ],
      ),
    );
  }

  void _mostrarModalPagamentoInicial() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Escolha a forma de pagamento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _opcoesPagamento.map((opcao) {
            return RadioListTile<String>(
              title: Text(opcao,),
              value: opcao,
              groupValue: _metodoSelecionado,
              onChanged: (value) {
                setState(() {
                  _metodoSelecionado = value!;
                });
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar', style: TextStyle(color: AppColors.corPrincipal)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _mostrarModalEtapaPagamento();
            },
            style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corPrincipal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
            child: const Text('Próximo', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _mostrarModalEtapaPagamento() {
    if (_metodoSelecionado == 'Pix') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Pagamento via Pix'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text('QR CODE')),
              ),
              const SizedBox(height: 20),
              const Text('Escaneie o código com seu app bancário.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar', style: TextStyle(color: AppColors.corPrincipal)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _mostrarConfirmacao();
              },
              style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corPrincipal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
              child: const Text('Concluir'),
            ),
          ],
        ),
      );
    } else if (_metodoSelecionado == 'Cartão de crédito') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Dados do Cartão'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TextField(
                decoration: InputDecoration(labelText: 'Número do cartão'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nome no cartão'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Validade (MM/AA)'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _mostrarConfirmacao();
              },
              style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.corPrincipal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
              child: const Text('Concluir'),
            ),
          ],
        ),
      );
    } else {
      _mostrarConfirmacao();
    }
  }

  void _mostrarConfirmacao() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 50),
        title: const Text('Pagamento realizado!'),
        content: const Text('Seu estacionamento foi adicionado com sucesso.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
