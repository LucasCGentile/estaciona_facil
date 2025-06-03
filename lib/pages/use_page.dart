import 'package:flutter/material.dart';

class UsePage extends StatefulWidget {
  const UsePage({super.key, required this.title});

  final String title;

  @override
  State<UsePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Pagina para historico de tickets')),
    );
  }
}
