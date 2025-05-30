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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 195, 195, 195),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Termos de Uso',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '1. Aceitação dos Termos\n'
                    'Ao utilizar este aplicativo, você concorda com os termos e condições aqui descritos.\n\n'
                    '2. Uso do Aplicativo\n'
                    'Você concorda em usar o aplicativo apenas para fins legais e de acordo com as leis aplicáveis.\n\n'
                    '3. Modificações nos Termos\n'
                    'Reservamos o direito de modificar estes termos a qualquer momento. As alterações serão publicadas nesta página.\n\n'
                    '4. Limitação de Responsabilidade\n'
                    'Não nos responsabilizamos por quaisquer danos diretos ou indiretos decorrentes do uso do aplicativo.\n\n'
                    '5. Lei Aplicável\n'
                    'Estes termos são regidos pelas leis do país onde o aplicativo é disponibilizado.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
        ));
  }
}
