import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key, required this.title});

  final String title;

  @override
  State<TicketPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('pagina comprar ticket')));
  }
}
