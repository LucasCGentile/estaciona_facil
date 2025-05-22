import 'package:estaciona_facil/pages/first_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estaciona Facil - eFacil Sao Roque',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF5EEEE)),
      home: const FirstPage(title: 'Estaciona Facil - eFacil Sao Roque'),
    );
  }
}
