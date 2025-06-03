import 'package:estaciona_facil/assets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key, required this.title});

  final String title;

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class Cartao {
  final String tipo; // 'Crédito' ou 'Débito'
  final String nomeTitular;
  final String numero; // já formatado com espaços
  final String validade; // MM/YY
  final String cvv;

  Cartao({
    required this.tipo,
    required this.nomeTitular,
    required this.numero,
    required this.validade,
    required this.cvv,
  });

  String get numeroFormatado {
    // Já vem formatado, mas para garantir:
    return numero;
  }

  String get displayName => '$tipo - $numeroFormatado';
}

class _ConfigPageState extends State<ConfigPage> {
  String? _metodoPagamentoSelecionado;
  bool _notificacaoPromocao = false;
  bool _alertaTempoEstacionamento = false;
  bool _compraAutomatica = false;

  final TextEditingController _horaController = TextEditingController();

  final List<Cartao> _cartoes = [];

  String? _validarHora(String? value) {
    if (value == null || value.isEmpty) return null;
    final partes = value.split(':');
    if (partes.length != 2) return 'Formato inválido';
    final hora = int.tryParse(partes[0]);
    final minuto = int.tryParse(partes[1]);
    if (hora == null || minuto == null) return 'Formato inválido';
    if (hora < 0 || hora > 12) return 'Hora deve ser 00 a 12';
    if (minuto < 0 || minuto > 60) return 'Minuto deve ser 00 a 60';
    return null;
  }

  @override
  void dispose() {
    _horaController.dispose();
    super.dispose();
  }

  Future<void> _abrirModalCadastroCartao(String tipo) async {
    final nomeController = TextEditingController();
    final numeroController = TextEditingController();
    final validadeController = TextEditingController();
    final cvvController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Adicionar Cartão de $tipo'),
            content: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do titular',
                      ),
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Campo obrigatório'
                                  : null,
                    ),
                    TextFormField(
                      controller: numeroController,
                      decoration: const InputDecoration(
                        labelText: 'Número do cartão',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CartaoNumberInputFormatter(),
                      ],
                      validator: (v) {
                        if (v == null) return 'Campo obrigatório';
                        // Remover espaços para contar os dígitos
                        final digitos = v.replaceAll(' ', '');
                        if (digitos.length != 16) {
                          return 'Número deve ter 16 dígitos';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: validadeController,
                      decoration: const InputDecoration(
                        labelText: 'Validade (MM/YY)',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        ValidadeInputFormatter(),
                      ],
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Campo obrigatório';
                        final regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
                        if (!regex.hasMatch(v)) {
                          return 'Formato inválido (MM/YY)';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: cvvController,
                      decoration: const InputDecoration(labelText: 'CVV'),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Campo obrigatório';
                        if (v.length != 3) return 'CVV deve ter 3 dígitos';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      _cartoes.add(
                        Cartao(
                          tipo: tipo,
                          nomeTitular: nomeController.text,
                          numero: numeroController.text,
                          validade: validadeController.text,
                          cvv: cvvController.text,
                        ),
                      );
                      _metodoPagamentoSelecionado = _cartoes.last.displayName;
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    final paddingInterno = const EdgeInsets.all(16);

    List<DropdownMenuItem<String>> itensDropdown = [
      const DropdownMenuItem(value: 'PIX', child: Text('PIX')),
      const DropdownMenuItem(
        value: 'Lucas Silva **** **** **** 4673',
        child: Text('Lucas Silva **** **** **** 4673'),
      ),
      const DropdownMenuItem(value: 'Boleto', child: Text('Boleto')),
    ];

    // Adiciona cartões cadastrados ao dropdown com ícone X para remover
    itensDropdown.addAll(
      _cartoes.map(
        (cartao) => DropdownMenuItem(
          value: cartao.displayName,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cartao.displayName),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_metodoPagamentoSelecionado == cartao.displayName) {
                      _metodoPagamentoSelecionado = null;
                    }
                    _cartoes.remove(cartao);
                  });
                },
                child: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Container 1: Preferências de pagamento
            Container(
              width: double.infinity,
              padding: paddingInterno,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Configurações',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Preferências de pagamento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _metodoPagamentoSelecionado,
                    hint: const Text('Escolha um método'),
                    items: itensDropdown,
                    onChanged: (valor) async {
                      if (valor == 'Adicionar Cartão de Crédito') {
                        await _abrirModalCadastroCartao('Crédito');
                      } else if (valor == 'Adicionar Cartão de Débito') {
                        await _abrirModalCadastroCartao('Débito');
                      } else {
                        setState(() {
                          _metodoPagamentoSelecionado = valor;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: borderRadius),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Container 2: Notificações
            Container(
              width: double.infinity,
              padding: paddingInterno,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notificações',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text('Receber notificações de promoções'),
                      ),
                      Switch(
                        value: _notificacaoPromocao,
                        activeColor: AppColors.corPrincipal,
                        onChanged: (val) {
                          setState(() {
                            _notificacaoPromocao = val;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Receber Alerta de Tempo de Estacionamento',
                        ),
                      ),
                      Switch(
                        value: _alertaTempoEstacionamento,
                        activeColor: AppColors.corPrincipal,
                        onChanged: (val) {
                          setState(() {
                            _alertaTempoEstacionamento = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Container 3: Compra automática de Ticket
            Container(
              width: double.infinity,
              padding: paddingInterno,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Compra automática de Ticket',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: Text('Compras automáticas')),
                      Switch(
                        value: _compraAutomatica,
                        activeColor: AppColors.corPrincipal,
                        onChanged: (val) {
                          setState(() {
                            _compraAutomatica = val;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _horaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Horário (HH:MM)',
                      hintText: '00:00',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      HorarioInputFormatter(),
                    ],
                    validator: _validarHora,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Formatter para número do cartão com espaço a cada 4 dígitos
class CartaoNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digitsOnly = newValue.text.replaceAll(' ', '');
    if (digitsOnly.length > 16) {
      digitsOnly = digitsOnly.substring(0, 16);
    }
    final buffer = StringBuffer();
    for (var i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      var isLastChar = i == digitsOnly.length - 1;
      if ((i + 1) % 4 == 0 && !isLastChar) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Formatter para validade MM/YY
class ValidadeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digitsOnly = newValue.text.replaceAll('/', '');
    if (digitsOnly.length > 4) digitsOnly = digitsOnly.substring(0, 4);

    final buffer = StringBuffer();
    for (var i = 0; i < digitsOnly.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(digitsOnly[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Formatter para o campo de horário HH:MM
class HorarioInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(':', '');
    if (text.length > 4) text = text.substring(0, 4);

    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      if (i == 2) buffer.write(':');
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
