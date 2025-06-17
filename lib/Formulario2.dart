import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(debugShowCheckedModeBanner: false, home: FormularioPage2()),
);

class FormularioPage2 extends StatefulWidget {
  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage2> {
  final _formKey = GlobalKey<FormState>();
  String? _respostaFrutas;
  String? _respostaCafe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // ação de voltar ainda não implementada
              },
            ),
            centerTitle: true,
            title: Image.asset('assents/images/FiebCDM2.png', height: 98),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Fundo degradê
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF732457), Color(0xFF8C336D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Imagem por cima do degradê
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assents/images/CDM.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Conteúdo principal
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Por favor, informe se há alguma alergia ou restrição alimentar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Descreva aqui. . .',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, informe se há alguma restrição alimentar';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Por favor, informe se há alguma alergia ou restrição alimentar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Descreva aqui. . .',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preencha este campo';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Costuma incluir frutas em sua dieta diária?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        RadioListTile<String>(
                          title: Text('Sim'),
                          value: 'Sim',
                          groupValue: _respostaFrutas,
                          onChanged: (value) {
                            setState(() {
                              _respostaFrutas = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Não'),
                          value: 'Não',
                          groupValue: _respostaFrutas,
                          onChanged: (value) {
                            setState(() {
                              _respostaFrutas = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Eventualmente'),
                          value: 'Eventualmente',
                          groupValue: _respostaFrutas,
                          onChanged: (value) {
                            setState(() {
                              _respostaFrutas = value;
                            });
                          },
                        ),
                        SizedBox(height: 30),
                        Text(
                          'O café da manhã faz parte da sua rotina alimentar diária?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        RadioListTile<String>(
                          title: Text('Sim'),
                          value: 'Sim',
                          groupValue: _respostaCafe,
                          onChanged: (value) {
                            setState(() {
                              _respostaCafe = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Não'),
                          value: 'Não',
                          groupValue: _respostaCafe,
                          onChanged: (value) {
                            setState(() {
                              _respostaCafe = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Eventualmente'),
                          value: 'Eventualmente',
                          groupValue: _respostaCafe,
                          onChanged: (value) {
                            setState(() {
                              _respostaCafe = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Formulário enviado!'),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFA3BF3B),
                                    Color(0xFF6FAC45),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Enviar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
