import 'package:flutter/material.dart';
import 'Formulario2.dart';

class FormularioPage extends StatefulWidget {
  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  String? _turnoSelecionado;
  String? _frequenciaSelecionada;
  final TextEditingController _pratosPositivosController =
      TextEditingController();
  final TextEditingController _pratosNegativosController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo degradê
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 109, 34, 83), Color(0xFF8C336D)],
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
          Column(
            children: [
              PreferredSize(
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
                    centerTitle: true,
                    title: Image.asset(
                      'assents/images/FiebCDM2.png',
                      height: 98,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
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
                      child: Stack(
                        children: [
                          Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Em que turno você estuda?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  ...['Matutino', 'Vespertino', 'Noturno']
                                      .map(
                                        (turno) => RadioListTile<String>(
                                          title: Text(turno),
                                          value: turno,
                                          groupValue: _turnoSelecionado,
                                          onChanged: (val) {
                                            setState(() {
                                              _turnoSelecionado = val;
                                            });
                                          },
                                        ),
                                      )
                                      .toList(),
                                  SizedBox(height: 24),
                                  Text(
                                    'Qual é a frequência com que você faz as refeições na escola?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  ...[
                                        'Sempre',
                                        'Nunca',
                                        'Eventualmente',
                                        'Raramente',
                                      ]
                                      .map(
                                        (opcao) => RadioListTile<String>(
                                          title: Text(opcao),
                                          value: opcao,
                                          groupValue: _frequenciaSelecionada,
                                          onChanged: (val) {
                                            setState(() {
                                              _frequenciaSelecionada = val;
                                            });
                                          },
                                        ),
                                      )
                                      .toList(),
                                  SizedBox(height: 24),
                                  Text(
                                    'Quais pratos você considera mais agradáveis?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _pratosPositivosController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Descreva aqui...',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, escreva sua resposta.';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    'Quais pratos você considera menos agradáveis?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _pratosNegativosController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Descreva aqui...',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, escreva sua resposta.';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 60),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  if (_turnoSelecionado == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Selecione uma opção para o turno de estudo.',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  if (_frequenciaSelecionada == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Selecione uma opção para a frequência das refeições.',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final DateTime? dataFinal =
                                      await Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: Duration(
                                            milliseconds: 500,
                                          ),
                                          pageBuilder:
                                              (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                              ) => FormularioPage2(),
                                          transitionsBuilder: (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            final scaleAnimation =
                                                Tween<double>(
                                                  begin: 0.8,
                                                  end: 1.0,
                                                ).animate(
                                                  CurvedAnimation(
                                                    parent: animation,
                                                    curve: Curves.easeOutBack,
                                                  ),
                                                );

                                            return ScaleTransition(
                                              scale: scaleAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );

                                  if (dataFinal != null) {
                                    Navigator.pop(context, dataFinal);
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
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
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Próximo',
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
            ],
          ),
        ],
      ),
    );
  }
}
