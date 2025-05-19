import 'package:flutter/material.dart';

class vehicle_page extends StatefulWidget {
  const vehicle_page({super.key, required this.title});

  final String title;

  @override
  State<vehicle_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<vehicle_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('pagina carro')));
  }
}
