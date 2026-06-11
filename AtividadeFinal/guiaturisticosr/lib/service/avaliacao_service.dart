import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/avaliacao.dart';

class AvaliacaoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> salvarAvaliacao(String pontoTuristico, Avaliacao avaliacao) async {
    await _firestore
        .collection('avaliacoes')
        .doc(pontoTuristico)
        .collection('itens')
        .add(avaliacao.toMap());
  }

  // sempre que uma avaliação for adicionada, alterada ou removida
  // processo é atualizado em tempo real
  Stream<QuerySnapshot> carregarAvaliacoes(String pontoTuristico) {
    return FirebaseFirestore.instance
        .collection('avaliacoes')
        .doc(pontoTuristico)
        .collection('itens')
        .snapshots();
  }
}
