class Usuario {
  final int id;
  final String rm;
  final String nome;

  Usuario({
    required this.id,
    required this.rm,
    required this.nome,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      rm: json['rm'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rm': rm,
      'nome': nome,
    };
  }
}
