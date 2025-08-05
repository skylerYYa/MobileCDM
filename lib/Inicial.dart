import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'usuario.dart';
import 'Formulario.dart'; // Certifique-se de que está correto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: InicialPage(), debugShowCheckedModeBanner: false);
  }
}

class InicialPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<InicialPage> {
  final TextEditingController rmController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  String rmError = "";
  String senhaError = "";

  void _validateFields() async {
    setState(() {
      rmError = rmController.text.isEmpty ? "Preencha o campo com as informações" : "";
      senhaError = senhaController.text.isEmpty ? "Preencha o campo com as informações" : "";
    });

    if (rmController.text.isNotEmpty && senhaController.text.isNotEmpty) {
      final usuario = await _fazerLogin(rmController.text, senhaController.text);
      if (usuario != null) {
        _showSuccessDialog(usuario);
      } else {
        _showErrorDialog();
      }
    }
  }

  Future<Usuario?> _fazerLogin(String rm, String senha) async {
    final url = Uri.parse('http://localhost:8080/usuario/login-mobile'); // ajuste IP se necessário
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'rm': rm, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Usuario.fromJson(json);
    } else {
      return null;
    }
  }

  void _showSuccessDialog(Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Login confirmado!"),
        content: Text("Bem-vindo, ${usuario.nome}!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(_createBounceRoute(usuario));
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro"),
        content: Text("Dados incorretos ou problema na conexão"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
        ],
      ),
    );
  }

  Route _createBounceRoute(Usuario usuario) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          FormularioPage(usuario: usuario),
      transitionDuration: Duration(milliseconds: 600),
      reverseTransitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final bounceIn = CurvedAnimation(parent: animation, curve: Curves.elasticOut);
        final scaleOut = Tween<double>(begin: 1.0, end: 0.7).animate(
          CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInOut),
        );

        return ScaleTransition(
          scale: animation.status == AnimationStatus.reverse ? scaleOut : bounceIn,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF732457), Color(0xFF8C336D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 1,
            child: Image.asset('assents/images/CDM.png', fit: BoxFit.cover),
          ),
        ),
        Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Image.asset(
                  "assents/images/FiebCDM2.png",
                  height: 98,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                      SizedBox(height: 20),
                      _buildTextField("Rm...", controller: rmController, errorText: rmError),
                      SizedBox(height: 10),
                      _buildTextField("Senha...", controller: senhaController, obscureText: true, errorText: senhaError),
                      SizedBox(height: 20),
                      _buildGradientButton(context, "Entrar"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildTextField(
    String hint, {
    required TextEditingController controller,
    bool obscureText = false,
    required String errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: hint,
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 8),
            child: Text(errorText, style: TextStyle(color: Colors.red, fontSize: 14)),
          ),
      ],
    );
  }

  Widget _buildGradientButton(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: _validateFields,
        child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}
