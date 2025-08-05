class Usuario {
  final String rm;
  final String nome;

  Usuario({required this.rm, required this.nome});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      rm: json['rm'],
      nome: json['nome'],
    );
  }
}
