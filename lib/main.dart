import 'package:flutter/material.dart';
import 'Inicial.dart';

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

class EntradaPage extends StatefulWidget {
  @override
  _EntradaPageState createState() => _EntradaPageState();
}

class _EntradaPageState extends State<EntradaPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Route _createBounceRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => InicialPage(),
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final bounceAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut,
        );
        return ScaleTransition(scale: bounceAnimation, child: child);
      },
    );
  }

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
                colors: [Color(0xFFEBEBEB), Color(0xFFFFFFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Primeira imagem de fundo
          Positioned.fill(
            child: Image.asset(
              'assents/images/Grade.png', // substitua pelo caminho correto
              fit: BoxFit.cover,
            ),
          ),

          // Segunda imagem de fundo com opacidades
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // ajuste conforme desejado
              child: Image.asset(
                'assents/images/CDM.png', // substitua pelo caminho correto
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Conteúdo da tela
          Column(
            children: [
              // Aba superior sem animação
              Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFa64182), Color(0xFF883069)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assents/images/cdmgarfo.png',
                    width: 600,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Conteúdo animado abaixo
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        Spacer(flex: 3),
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Center(
                            child: Image.asset(
                              'assents/images/FIAB.png',
                              width: 300,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
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
                              padding: EdgeInsets.symmetric(
                                horizontal: 80,
                                vertical: 25,
                              ),
                            ),
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
