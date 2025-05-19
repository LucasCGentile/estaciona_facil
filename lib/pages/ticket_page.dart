import 'package:flutter/material.dart';

class ticket_page extends StatefulWidget {
  const ticket_page({super.key, required this.title});

  final String title;

  @override
  State<ticket_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ticket_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('pagina tickets')));
  }
}
