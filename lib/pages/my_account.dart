import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key, required this.title});

  final String title;

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  // Dados simulados
  final String _nome = 'Lucas Silva';
  final String _cif = '123.456.789-00';

  // Campos editáveis
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  // Estado inicial para comparação
  String _emailOriginal = 'lucas@email.com';
  String _telefoneOriginal = '(11) 91234-5678';

  @override
  void initState() {
    super.initState();
    _emailController.text = _emailOriginal;
    _telefoneController.text = _telefoneOriginal;
  }

  void _atualizarDados() {
    final emailAlterado = _emailController.text != _emailOriginal;
    final telefoneAlterado = _telefoneController.text != _telefoneOriginal;

    if (emailAlterado || telefoneAlterado) {
      setState(() {
        _emailOriginal = _emailController.text;
        _telefoneOriginal = _telefoneController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados atualizados com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma alteração detectada.')),
      );
    }
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          initialValue: value,
          enabled: false,
          decoration: const InputDecoration(
            disabledBorder: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Dados')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildReadOnlyField('Nome', _nome),
            _buildEditableField(
              'E-mail',
              _emailController,
              'Digite seu e-mail',
            ),
            _buildReadOnlyField('CIF', _cif),
            _buildEditableField(
              'Telefone',
              _telefoneController,
              'Digite seu telefone',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _atualizarDados,
              child: const Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
