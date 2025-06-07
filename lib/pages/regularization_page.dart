import 'package:flutter/material.dart';

class RegularizationPage extends StatefulWidget {
  const RegularizationPage({super.key, required this.title});

  final String title;

  @override
  State<RegularizationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegularizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
          children: [Text('Tela de Regularização de Veículos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))],
        )
             ));
  }
}
