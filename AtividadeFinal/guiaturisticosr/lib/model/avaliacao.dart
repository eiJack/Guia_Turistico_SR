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
}
