import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ObrigadoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ObrigadoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com degradê diagonal
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft, // canto superior esquerdo
                  end: Alignment.bottomRight, // canto inferior direito
                  colors: [Color(0xFF47283C), Color(0xFF47283C)],
                ),
              ),
            ),
          ),
          // Padrão da imagem "FEB" com opacidade
          Positioned.fill(
            child: Opacity(
              opacity: 1,
              child: Image.asset('assents/images/CDM.png', fit: BoxFit.cover),
            ),
          ),
          // Conteúdo central
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 299,
                  height: 299,
                  child: Image.asset(
                    'assents/images/Sorriso.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Obrigado!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Botão estilizado com degradê e sombra
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Ação ao clicar
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Próximo',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
