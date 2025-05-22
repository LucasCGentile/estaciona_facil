import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key, required this.title});

  final String title;

  @override
  State<ConfigPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Pagina p/ configurações')));
  }
}
