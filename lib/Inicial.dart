import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GradientBackgroundScreen(),
    );
  }
}

class GradientBackgroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com gradiente
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF732457), Color(0xFF8C336D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Imagem de fundo semi-transparente
          Positioned.fill(
            child: Opacity(
              opacity: 1, // Ajuste de transparência da imagem
              child: Image.asset('assents/images/CDM.png', fit: BoxFit.cover),
            ),
          ),
          // Coluna com conteúdo sobreposto
          Column(
            children: [
              // Aba superior com imagem centralizada
              Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assents/images/FiebCDM2.png',
                    width: 900, // Ajuste do tamanho da imagem
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Spacer(flex: 3),
              // Imagem no meio da tela
              Center(
                child: Image.asset(
                  'assents/images/Garfo.png',
                  width: 300, // Ajuste do tamanho da imagem
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Spacer(flex: 2),
              // Botão com degradê
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFFA3BF3B), const Color(0xFF6FAC45)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    print('Botão Entrar pressionado!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Mantém o gradiente
                    shadowColor:
                        Colors
                            .transparent, // Remove sombra para um visual limpo
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 25),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
