import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key, required this.title});

  final String title;

  @override
  State<TermsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Pagina de termos de uso')));
  }
}
