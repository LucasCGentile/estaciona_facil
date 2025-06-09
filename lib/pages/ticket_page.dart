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

  double _valorTotal = 2.0; // Valor inicial

  void _mostrarModalPagamento() {
    if (_metodoSelecionado == 'Pix') {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Pagamento via Pix'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                     child: const Center(child: Image(image: AssetImage('lib/assets/img/qrcode.jpeg'))),
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
                  child: const Text('Concluir', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
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
                  child: const Text('Fechar', style: TextStyle(color: AppColors.corPrincipal),),
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
                  child: const Text('Concluir', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
      );
    }
  }

  void _mostrarConfirmacao() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
            title: const Text('Pagamento realizado!'),
            content: const Text('Seu ticket foi adquirido com sucesso.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fechar', style: TextStyle(color: AppColors.corPrincipal)),
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
                  'Deseja adquirir Saldo? \nSelecione o valor abaixo:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_valorTotal > 2.0) {
                            _valorTotal -= 2.0;
                          }
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.corPrincipal,
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
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
                          'TOTAL (R\$)\n${_valorTotal.toStringAsFixed(2)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.corPrincipal,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_valorTotal < 20.0) {
                            _valorTotal += 2.0;
                          }
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.corPrincipal,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
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
                    border: Border.all(
                      color: AppColors.corPrincipal,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children:
                        _opcoesPagamento.map((opcao) {
                          return RadioListTile<String>(
                            title: Text(opcao),
                            value: opcao,
                            groupValue: _metodoSelecionado,
                            activeColor: AppColors.corPrincipal,
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
                    backgroundColor: AppColors.corPrincipal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Concluir Pagamento',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
