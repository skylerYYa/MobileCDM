import 'package:flutter/material.dart';
import 'usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/formulario_model.dart';
import 'Editar.dart';

class FormularioPage extends StatefulWidget {
  final Usuario usuario;
  final FormularioModel? formularioPreenchido;

  const FormularioPage({
    super.key,
    required this.usuario,
    this.formularioPreenchido,
  });

  @override
  _FormularioCompletoPageState createState() => _FormularioCompletoPageState();
}

class _FormularioCompletoPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  String? _turnoSelecionado;
  String? _frequenciaSelecionada;
  final _pratosPositivosController = TextEditingController();
  final _pratosNegativosController = TextEditingController();
  final _restricao1Controller = TextEditingController();
  final _restricao2Controller = TextEditingController();
  String? _respostaFrutas;
  String? _respostaCafe;

  @override
  void initState() {
    super.initState();
    final f = widget.formularioPreenchido;
    if (f != null) {
      _turnoSelecionado = f.turno;
      _frequenciaSelecionada = f.frequenciaRefeicao;
      _pratosPositivosController.text = f.pratosAgradaveis;
      _pratosNegativosController.text = f.pratosMenos;
      _restricao1Controller.text = f.restricoes;
      _respostaFrutas = f.frequenciaSobremesa;
      _respostaCafe = f.frequenciaCafe;
    }
  }

  Future<void> _enviarFormulario() async {
    final url = Uri.parse('http://localhost:8080/formulario/save');

    final formulario = FormularioModel(
      usuarioId: widget.usuario.id,
      turno: _turnoSelecionado!,
      frequenciaRefeicao: _frequenciaSelecionada!,
      pratosAgradaveis: _pratosPositivosController.text,
      pratosMenos: _pratosNegativosController.text,
      restricoes: _restricao1Controller.text,
      frequenciaSobremesa: _respostaFrutas!,
      frequenciaCafe: _respostaCafe!,
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(formulario.toJson()),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Sucesso'),
                content: Text('Formulário enviado com sucesso!! Obrigada.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => EditarPage(
                                usuario: widget.usuario,
                                formulario: formulario,
                              ),
                        ),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar formulário: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro de conexão: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFa64182), Color(0xFF883069)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Image.asset('assents/images/cdmgarfo.png', height: 60),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFEBEBEB), Color(0xFFFFFFFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset('assents/images/CDM.png', fit: BoxFit.cover),
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
                        Text('Em que turno você estuda?', style: _titulo()),
                        ...['Matutino', 'Vespertino', 'Noturno'].map(
                          (turno) => RadioListTile<String>(
                            title: Text(turno),
                            value: turno,
                            groupValue: _turnoSelecionado,
                            onChanged:
                                (val) =>
                                    setState(() => _turnoSelecionado = val),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Com que frequência você faz refeições na escola?',
                          style: _titulo(),
                        ),
                        DropdownButtonFormField<String>(
                          value: _frequenciaSelecionada,
                          items:
                              ['Todos os dias', 'Alguns dias', 'Raramente']
                                  .map(
                                    (opcao) => DropdownMenuItem(
                                      value: opcao,
                                      child: Text(opcao),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (val) =>
                                  setState(() => _frequenciaSelecionada = val),
                          validator:
                              (value) =>
                                  value == null ? 'Campo obrigatório' : null,
                        ),
                        SizedBox(height: 16),
                        Text('Quais pratos você gosta?', style: _titulo()),
                        _campoTexto(_pratosPositivosController),
                        SizedBox(height: 16),
                        Text('Quais pratos você não gosta?', style: _titulo()),
                        _campoTexto(_pratosNegativosController),
                        SizedBox(height: 16),
                        Text(
                          'Você tem alguma restrição alimentar?',
                          style: _titulo(),
                        ),
                        _campoTexto(_restricao1Controller),
                        SizedBox(height: 16),
                        Text(
                          'Com que frequência você consome sobremesa?',
                          style: _titulo(),
                        ),
                        ...['Sempre', 'Às vezes', 'Nunca'].map(
                          (resposta) => RadioListTile<String>(
                            title: Text(resposta),
                            value: resposta,
                            groupValue: _respostaFrutas,
                            onChanged:
                                (val) => setState(() => _respostaFrutas = val),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Com que frequência você consome café?',
                          style: _titulo(),
                        ),
                        ...['Sempre', 'Às vezes', 'Nunca'].map(
                          (resposta) => RadioListTile<String>(
                            title: Text(resposta),
                            value: resposta,
                            groupValue: _respostaCafe,
                            onChanged:
                                (val) => setState(() => _respostaCafe = val),
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                if (_turnoSelecionado == null ||
                                    _frequenciaSelecionada == null ||
                                    _respostaFrutas == null ||
                                    _respostaCafe == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Preencha todas as opções obrigatórias',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                _enviarFormulario();
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
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Campo obrigatório' : null,
    );
  }
}
