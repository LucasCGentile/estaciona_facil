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

  int _quantidadeTickets = 1;

  // Lista de cartões salvos
  final List<Map<String, String>> _cartoesSalvos = [];

  Map<String, String>? _cartaoSelecionado;

  final _formKeyCartao = GlobalKey<FormState>();

  // Controllers para o modal adicionar cartão
  final _nomeController = TextEditingController();
  final _numeroController = TextEditingController();
  final _validadeController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _numeroController.dispose();
    _validadeController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // Formatação número cartão: espaço a cada 4 dígitos
  String _formatarNumeroCartao(String texto) {
    texto = texto.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < texto.length; i++) {
      buffer.write(texto[i]);
      if ((i + 1) % 4 == 0 && i != texto.length - 1) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }

  // Formatação validade MM/YY
  String _formatarValidade(String texto) {
    texto = texto.replaceAll('/', '');
    if (texto.length > 4) texto = texto.substring(0, 4);
    String mm = '';
    String yy = '';
    if (texto.length >= 2) {
      mm = texto.substring(0, 2);
      yy = texto.substring(2);
    } else {
      mm = texto;
    }
    if (mm.length == 1 && int.tryParse(mm)! > 1) {
      mm = '0$mm';
    }
    if (mm.length == 2) {
      int mmNum = int.tryParse(mm) ?? 0;
      if (mmNum > 12) {
        mm = '12';
      } else if (mmNum == 0) {
        mm = '01';
      }
    }
    return yy.isEmpty ? mm : '$mm/$yy';
  }

  // Gera string aleatória para chave Pix
  String _gerarChavePixAleatoria() {
    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(
      20,
      (index) => caracteres[random.nextInt(caracteres.length)],
    ).join();
  }

  void _mostrarModalAdicionarCartao() {
    _nomeController.clear();
    _numeroController.clear();
    _validadeController.clear();
    _cvvController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Cartão'),
          content: Form(
            key: _formKeyCartao,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nome do titular
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Titular',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe o nome do titular';
                      }
                      return null;
                    },
                  ),
                  // Número do cartão
                  TextFormField(
                    controller: _numeroController,
                    decoration: const InputDecoration(
                      labelText: 'Número do Cartão',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        String numLimpo = newValue.text.replaceAll(' ', '');
                        String textoFormatado = _formatarNumeroCartao(numLimpo);
                        return TextEditingValue(
                          text: textoFormatado,
                          selection: TextSelection.collapsed(
                            offset: textoFormatado.length,
                          ),
                        );
                      }),
                    ],
                    validator: (value) {
                      if (value == null) return 'Informe o número do cartão';
                      String numLimpo = value.replaceAll(' ', '');
                      if (numLimpo.length != 16) {
                        return 'Número deve ter 16 dígitos';
                      }
                      return null;
                    },
                  ),
                  // Data de validade
                  TextFormField(
                    controller: _validadeController,
                    decoration: const InputDecoration(
                      labelText: 'Validade (MM/YY)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        String texto = newValue.text;
                        texto = _formatarValidade(texto);
                        return TextEditingValue(
                          text: texto,
                          selection: TextSelection.collapsed(
                            offset: texto.length,
                          ),
                        );
                      }),
                    ],
                    validator: (value) {
                      if (value == null || value.length != 5) {
                        return 'Informe validade no formato MM/YY';
                      }
                      final partes = value.split('/');
                      if (partes.length != 2) return 'Formato inválido';
                      int? mm = int.tryParse(partes[0]);
                      int? yy = int.tryParse(partes[1]);
                      if (mm == null || mm < 1 || mm > 12) {
                        return 'Mês inválido';
                      }
                      if (yy == null) return 'Ano inválido';
                      return null;
                    },
                  ),
                  // CVV
                  TextFormField(
                    controller: _cvvController,
                    decoration: const InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    validator: (value) {
                      if (value == null || value.length != 3) {
                        return 'Informe o CVV (3 dígitos)';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKeyCartao.currentState!.validate()) {
                  // Salvar cartão
                  setState(() {
                    _cartoesSalvos.add({
                      'nome': _nomeController.text.trim(),
                      'numero': _numeroController.text.trim(),
                      'validade': _validadeController.text.trim(),
                      'cvv': _cvvController.text.trim(),
                    });
                    _cartaoSelecionado = _cartoesSalvos.last;
                    _metodoSelecionado =
                        _cartaoSelecionado != null ? _metodoSelecionado : 'Pix';
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Salvar',
                style: TextStyle(color: AppColors.corPrincipal),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarModalPix() {
    String chavePix = _gerarChavePixAleatoria();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pagamento via Pix'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Aqui substitua a URL pela imagem do QR Code real que quiser usar
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/QR_Code_Example.svg/368px-QR_Code_Example.svg.png?20111025115625',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: chavePix));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chave Pix copiada!')),
                  );
                },
                child: Text(
                  chavePix,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Pagamento Realizado',
                  style: TextStyle(color: AppColors.corPrincipal),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
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
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        if (_quantidadeTickets > 1) {
                          setState(() => _quantidadeTickets--);
                        }
                      },
                    ),
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
                        'TOTAL (R\$)\n${(_quantidadeTickets * 2).toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    backgroundColor: AppColors.corPrincipal,
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        if (_quantidadeTickets < 10) {
                          setState(() => _quantidadeTickets++);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Selecione o método de pagamento:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _metodoSelecionado,
                items:
                    _opcoesPagamento
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (valor) {
                  setState(() {
                    _metodoSelecionado = valor!;
                    if (_metodoSelecionado != 'Pix') {
                      _cartaoSelecionado =
                          _cartoesSalvos.isNotEmpty ? _cartoesSalvos[0] : null;
                    } else {
                      _cartaoSelecionado = null;
                    }
                  });
                },
              ),
              const SizedBox(height: 20),

              // Se for cartão, mostra lista cartões
              if (_metodoSelecionado != 'Pix') ...[
                if (_cartoesSalvos.isEmpty)
                  Column(
                    children: [
                      const Text('Nenhum cartão salvo.'),
                      ElevatedButton(
                        onPressed: _mostrarModalAdicionarCartao,
                        child: const Text(
                          'Adicionar Cartão',
                          style: TextStyle(color: AppColors.corPrincipal),
                        ),
                      ),
                    ],
                  )
                else ...[
                  Column(
                    children: [
                      const Text('Cartões Salvos:'),
                      for (var cartao in _cartoesSalvos)
                        ListTile(
                          title: Text(cartao['nome']!),
                          subtitle: Text(
                            '**** **** **** ${cartao['numero']!.substring(cartao['numero']!.length - 4)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_cartaoSelecionado == cartao)
                                const Icon(Icons.check, color: Colors.green),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: const Text('Remover Cartão'),
                                          content: Text(
                                            'Tem certeza que deseja remover o cartão final '
                                            '${cartao['numero']!.substring(cartao['numero']!.length - 4)}?',
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancelar'),
                                              onPressed:
                                                  () =>
                                                      Navigator.of(
                                                        context,
                                                      ).pop(),
                                            ),
                                            TextButton(
                                              child: const Text('Remover'),
                                              onPressed: () {
                                                setState(() {
                                                  _cartoesSalvos.remove(cartao);
                                                  if (_cartaoSelecionado ==
                                                      cartao) {
                                                    _cartaoSelecionado = null;
                                                  }
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _cartaoSelecionado = cartao;
                            });
                          },
                        ),
                      ElevatedButton(
                        onPressed: _mostrarModalAdicionarCartao,
                        child: const Text(
                          'Adicionar Novo Cartão',
                          style: TextStyle(color: AppColors.corPrincipal),
                        ),
                      ),
                    ],
                  ),
                ],
              ],

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_metodoSelecionado == 'Pix') {
                    _mostrarModalPix();
                  } else {
                    if (_cartaoSelecionado == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Selecione um cartão para continuar.'),
                        ),
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Pagamento'),
                            content: Text(
                              'Pagamento via $_metodoSelecionado realizado com sucesso.',
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                    );
                  }
                },
                child: const Text(
                  'Finalizar Compra',
                  style: TextStyle(color: AppColors.corPrincipal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
