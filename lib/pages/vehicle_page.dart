import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:estaciona_facil/assets/app_colors.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key, required this.title});

  final String title;

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final List<Map<String, String>> _vehicles = [];

  void _addVehicle(String nome, String placa) {
    setState(() {
      _vehicles.add({'nome': nome, 'placa': placa});
    });
  }

  void _showConfirmVehicleDialog(String nome, String placa, BuildContext parentContext) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirme os dados do veículo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome: $nome'),
              const SizedBox(height: 8),
              Text('Placa: $placa'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _addVehicle(nome, placa); // Adiciona o veículo
                Navigator.of(context).pop(); // Fecha o AlertDialog
                Navigator.of(parentContext).pop(); // Fecha o modal inferior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.corPrincipal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showAddVehicleModal() {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController placaController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: screenHeight * 0.25,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Carro',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o nome do carro';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: placaController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Placa',
                        border: OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a placa';
                        } else if (value.trim().length < 7) {
                          return 'Placa incompleta';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String nome = nomeController.text.trim();
                          String placa = placaController.text.trim().toUpperCase();
                          _showConfirmVehicleDialog(nome, placa, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.corPrincipal,
                      ),
                      child: const Text(
                        'Salvar Veículo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showVehicleDeletedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Veículo excluído com sucesso!'),
          icon: const Icon( Icons.check_circle,
              color: Colors.green,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o alerta
              },
              child: const Text('OK', style: TextStyle(color: AppColors.corPrincipal)),
            ),
          ],
        );
      },
    );
  }

  void _deleteVehicle(Map<String, String> vehicle) {
    setState(() {
      _vehicles.remove(vehicle);
    });
    _showVehicleDeletedDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            const Center(
              child: Text(
                'Veículos Cadastrados',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            if (_vehicles.isEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Nenhum veículo cadastrado, adicione no botão abaixo:',
                  textAlign: TextAlign.center,
                ),
              ),
            ..._vehicles.map((vehicle) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text(vehicle['nome'] ?? ''),
                  subtitle: Text('Placa: ${vehicle['placa']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteVehicle(vehicle),
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Center(
              child: FloatingActionButton(
                onPressed: _showAddVehicleModal,
                backgroundColor: AppColors.corPrincipal,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
