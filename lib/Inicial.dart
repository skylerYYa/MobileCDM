import 'package:flutter/material.dart';
import 'main.dart'; // Certifique-se de que o caminho está correto para InicialPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EntradaPage(),
    );
  }
}

class EntradaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo gradiente
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
          // Imagem de fundo
          Positioned.fill(
            child: Opacity(
              opacity: 1,
              child: Image.asset('assents/images/CDM.png', fit: BoxFit.cover),
            ),
          ),
          // Conteúdo da tela
          Column(
            children: [
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
                    width: 900,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Spacer(flex: 3),
              Center(
                child: Image.asset(
                  'assents/images/Garfo.png',
                  width: 300,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Spacer(flex: 2),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(_createBounceRoute());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
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

  /// Rota com animação tipo "saltar" (bounce in)
  Route _createBounceRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => InicialPage(),
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final bounceAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut, // efeito de pulo
        );

        return ScaleTransition(scale: bounceAnimation, child: child);
      },
    );
  }
}
