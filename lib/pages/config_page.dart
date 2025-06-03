import 'dart:convert'; // Para jsonEncode/jsonDecode
import 'package:shared_preferences/shared_preferences.dart';

//...

class _ConfigPageState extends State<ConfigPage> {
  // ... seu código atual ...

  @override
  void initState() {
    super.initState();
    _carregarCartoesSalvos();
  }

  Future<void> _carregarCartoesSalvos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('cartoes');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      setState(() {
        _cartoes.clear();
        _cartoes.addAll(jsonList.map((e) => Cartao.fromJson(e)).toList());
      });
    }
  }

  Future<void> _salvarCartoes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_cartoes.map((c) => c.toJson()).toList());
    await prefs.setString('cartoes', jsonString);
  }

  Future<void> _abrirModalCadastroCartao(String tipo) async {
    // seu código atual...

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
          _salvarCartoes(); // salva no SharedPreferences aqui
          Navigator.pop(context);
        }
      },
      child: const Text('Salvar'),
    ),
    // ...
  }

  // Ao remover cartão
  void _removerCartao(Cartao cartao) {
    setState(() {
      if (_metodoPagamentoSelecionado == cartao.displayName) {
        _metodoPagamentoSelecionado = null;
      }
      _cartoes.remove(cartao);
    });
    _salvarCartoes(); // salva alteração
  }

  // No DropdownMenuItem:
  GestureDetector(
    onTap: () => _removerCartao(cartao),
    child: const Icon(Icons.close, color: Colors.red),
  ),

  // Depois que o usuário terminar a configuração, navegue para a página que recebe os cartões,
  // por exemplo, com um botão "Salvar e Continuar":
  ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TicketPage(cartoes: _cartoes),
        ),
      );
    },
    child: const Text('Salvar e Continuar'),
  );
}
