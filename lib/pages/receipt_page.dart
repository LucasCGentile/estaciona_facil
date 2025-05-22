import 'package:flutter/material.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key, required this.title});

  final String title;

  @override
  State<ReceiptPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('tela para comprovantes de adicionar saldo')),
    );
  }
}
