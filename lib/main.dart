import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen(), debugShowCheckedModeBanner: false);
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController rmController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  String rmError = "";
  String senhaError = "";

  void _validateFields() {
    setState(() {
      rmError =
          rmController.text.isEmpty
              ? "Preencha o campo com as informações"
              : "";
      senhaError =
          senhaController.text.isEmpty
              ? "Preencha o campo com as informações"
              : "";
    });

    if (rmController.text.isNotEmpty && senhaController.text.isNotEmpty) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Login confirmado! 😊"),
            content: Text("Bem-vindo!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cor de fundo com degradê
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF732457),
                  Color(0xFF8C336D),
                ], // Manter o degradê original
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
              // Barra superior com degradê e imagem centralizada
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
                    height: 98, // Define o tamanho da imagem
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
                      color: Colors.white.withOpacity(
                        0.9,
                      ), // Fundo semi-transparente para melhorar a legibilidade
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
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          "Rm...",
                          controller: rmController,
                          errorText: rmError,
                        ),
                        SizedBox(height: 10),
                        _buildTextField(
                          "Senha...",
                          controller: senhaController,
                          obscureText: true,
                          errorText: senhaError,
                        ),
                        SizedBox(height: 20),
                        _buildGradientButton(context, "Entrar"),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            // Lógica de recuperação de senha
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
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
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
      ],
    );
  }

  Widget _buildGradientButton(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)],
        ),
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
