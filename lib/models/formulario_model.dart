class FormularioModel {
  final int usuarioId;
  final String turno;
  final String frequenciaRefeicao;
  final String pratosAgradaveis;
  final String pratosMenos;
  final String restricoes;
  final String frequenciaSobremesa;
  final String frequenciaCafe;
  final String? statusFormulario;
  final DateTime? dataCadastro;

  FormularioModel({
    required this.usuarioId,
    required this.turno,
    required this.frequenciaRefeicao,
    required this.pratosAgradaveis,
    required this.pratosMenos,
    required this.restricoes,
    required this.frequenciaSobremesa,
    required this.frequenciaCafe,
    this.statusFormulario,
    this.dataCadastro,
  });

  /// Converte para JSON (envio para API)
  Map<String, dynamic> toJson() {
    return {
      "usuario": {
        "id": usuarioId,
      },
      "turno": turno,
      "frequenciaRefeicao": frequenciaRefeicao,
      "pratosAgradaveis": pratosAgradaveis,
      "pratosMenos": pratosMenos,
      "restricoes": restricoes,
      "frequenciaSobremesa": frequenciaSobremesa,
      "frequenciaCafe": frequenciaCafe,
      "statusFormulario": statusFormulario,
      "dataCadastro": dataCadastro?.toIso8601String(),
    };
  }

  /// Construtor a partir de JSON (resposta da API)
  factory FormularioModel.fromJson(Map<String, dynamic> json) {
    return FormularioModel(
      usuarioId: json['usuario']['id'],
      turno: json['turno'],
      frequenciaRefeicao: json['frequenciaRefeicao'],
      pratosAgradaveis: json['pratosAgradaveis'],
      pratosMenos: json['pratosMenos'],
      restricoes: json['restricoes'],
      frequenciaSobremesa: json['frequenciaSobremesa'],
      frequenciaCafe: json['frequenciaCafe'],
      statusFormulario: json['statusFormulario'],
      dataCadastro: json['dataCadastro'] != null
          ? DateTime.parse(json['dataCadastro'])
          : null,
    );
  }
}
