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
      body: SingleChildScrollView(
         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            

  Container(
  margin: EdgeInsets.symmetric(vertical: 2),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    children: [
      // Detalhe roxo na lateral esquerda
      Container(
        width: 6,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
      ),
      // Espaço interno e os textos
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Compras Crédito',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$10,00',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emissão:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),

                   Text(
                    '03/04/2025',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),

           Container(
  margin: EdgeInsets.symmetric(vertical: 2),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    children: [
      // Detalhe roxo na lateral esquerda
      Container(
        width: 6,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
      ),
      // Espaço interno e os textos
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Compras Crédito',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$10,00',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emissão:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),

                   Text(
                    '03/04/2025',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),

           Container(
  margin: EdgeInsets.symmetric(vertical: 2),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    children: [
      // Detalhe roxo na lateral esquerda
      Container(
        width: 6,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
      ),
      // Espaço interno e os textos
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Compras Crédito',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$10,00',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emissão:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),

                   Text(
                    '03/04/2025',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),

           Container(
  margin: EdgeInsets.symmetric(vertical: 2),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    children: [
      // Detalhe roxo na lateral esquerda
      Container(
        width: 6,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
      ),
      // Espaço interno e os textos
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Compras Crédito',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$10,00',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emissão:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),

                   Text(
                    '03/04/2025',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),

           Container(
  margin: EdgeInsets.symmetric(vertical: 2),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    children: [
      // Detalhe roxo na lateral esquerda
      Container(
        width: 6,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
      ),
      // Espaço interno e os textos
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Compras Crédito',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$10,00',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emissão:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),

                   Text(
                    '03/04/2025',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),



          ],
          ),
      ),
    );
  }
}
