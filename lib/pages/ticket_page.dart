import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:flutter/material.dart';

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

  void _mostrarModalPagamento() {
    if (_metodoSelecionado == 'Pix') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Pagamento via Pix'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Substitua por uma imagem real do QR Code, se quiser
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
              child: const Text('Fechar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _mostrarConfirmacao();
              },
              child: const Text('Concluir'),
            ),
          ],
        ),
      );
    } else {
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
              child: const Text('Concluir'),
            ),
          ],
        ),
      );
    }
  }

  void _mostrarConfirmacao() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pagamento realizado!'),
        content: const Text('Seu ticket foi adquirido com sucesso.'),
        icon: const Icon(Icons.check, color: Colors.green, size: 50,),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
                      child: const Icon(Icons.remove, color: Colors.white, size: 30),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    CircleAvatar(
                      backgroundColor: AppColors.corPrincipal,
                      child: const Icon(Icons.add, color: Colors.white, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Selecione a forma de pagamento:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _mostrarModalPagamento,
                  style: ElevatedButton.styleFrom(
                     backgroundColor: AppColors.corBotao,
                    foregroundColor: Colors.white,
                    fixedSize: Size(160, 50),
                    elevation:
                        8, // Altura da sombra (maior = sombra mais forte)
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    'Avançar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
