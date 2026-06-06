class Avaliacao {
  final String nomeUsuario;
  final String fotoUsuario;
  final int nota;
  final String comentario;
  final String? fotoAvaliacao;

  Avaliacao({
    required this.nomeUsuario,
    required this.fotoUsuario,
    required this.nota,
    required this.comentario,
    this.fotoAvaliacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomeUsuario': nomeUsuario,
      'fotoUsuario': fotoUsuario,
      'nota': nota,
      'comentario': comentario,
      'fotoAvaliacao': fotoAvaliacao,
    };
  }

  factory Avaliacao.fromMap(Map<String, dynamic> map) {
    return Avaliacao(
      nomeUsuario: map['nomeUsuario'],
      fotoUsuario: map['fotoUsuario'],
      nota: map['nota'],
      comentario: map['comentario'],
      fotoAvaliacao: map['fotoAvaliacao'],
    );
  }
}
