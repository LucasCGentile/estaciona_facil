import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key, required this.title});

  final String title;

  @override
  State<MyAccount> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Pagina Minha conta')));
  }
}
