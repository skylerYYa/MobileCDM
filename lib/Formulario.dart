import 'package:flutter/material.dart';
import 'Obrigado.dart';
import 'usuario.dart';

class FormularioPage extends StatefulWidget {
  final Usuario usuario;
  const FormularioPage({super.key, required this.usuario});

  @override
  _FormularioCompletoPageState createState() => _FormularioCompletoPageState();
}

class _FormularioCompletoPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  // Etapa 1
  String? _turnoSelecionado;
  String? _frequenciaSelecionada;
  final _pratosPositivosController = TextEditingController();
  final _pratosNegativosController = TextEditingController();

  // Etapa 2
  final _restricao1Controller = TextEditingController();
  final _restricao2Controller = TextEditingController();
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
            centerTitle: true,
            title: Image.asset('assents/images/FiebCDM2.png', height: 98),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF732457), Color(0xFF8C336D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assents/images/CDM.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Turno
                        Text('Em que turno você estuda?', style: _titulo()),
                        ...['Matutino', 'Vespertino', 'Noturno'].map(
                          (turno) => RadioListTile<String>(
                            title: Text(turno),
                            value: turno,
                            groupValue: _turnoSelecionado,
                            onChanged: (val) => setState(() => _turnoSelecionado = val),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Frequência
                        Text('Qual é a frequência com que você faz as refeições na escola?', style: _titulo()),
                        ...['Sempre', 'Nunca', 'Eventualmente', 'Raramente'].map(
                          (opcao) => RadioListTile<String>(
                            title: Text(opcao),
                            value: opcao,
                            groupValue: _frequenciaSelecionada,
                            onChanged: (val) => setState(() => _frequenciaSelecionada = val),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Pratos positivos
                        Text('Quais pratos você considera mais agradáveis?', style: _titulo()),
                        _campoTexto(_pratosPositivosController),

                        SizedBox(height: 24),
                        // Pratos negativos
                        Text('Quais pratos você considera menos agradáveis?', style: _titulo()),
                        _campoTexto(_pratosNegativosController),

                        SizedBox(height: 24),
                        // Restrição alimentar 1
                        Text('Informe se há alguma alergia ou restrição alimentar:', style: _titulo()),
                        _campoTexto(_restricao1Controller),

                        SizedBox(height: 24),
                        // Restrição alimentar 2
                        Text('Informe se há outra restrição alimentar:', style: _titulo()),
                        _campoTexto(_restricao2Controller),

                        SizedBox(height: 24),
                        // Frutas
                        Text('Costuma incluir frutas em sua dieta diária?', style: _titulo()),
                        ...['Sim', 'Não', 'Eventualmente'].map(
                          (opcao) => RadioListTile<String>(
                            title: Text(opcao),
                            value: opcao,
                            groupValue: _respostaFrutas,
                            onChanged: (val) => setState(() => _respostaFrutas = val),
                          ),
                        ),

                        SizedBox(height: 24),
                        // Café da manhã
                        Text('O café da manhã faz parte da sua rotina alimentar diária?', style: _titulo()),
                        ...['Sim', 'Não', 'Eventualmente'].map(
                          (opcao) => RadioListTile<String>(
                            title: Text(opcao),
                            value: opcao,
                            groupValue: _respostaCafe,
                            onChanged: (val) => setState(() => _respostaCafe = val),
                          ),
                        ),

                        SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                if (_turnoSelecionado == null || _frequenciaSelecionada == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Preencha todas as opções obrigatórias')),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ObrigadoPage()),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFFA3BF3B), Color(0xFF6FAC45)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text('Enviar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  TextStyle _titulo() => TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  Widget _campoTexto(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Descreva aqui...',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
    );
  }
}
