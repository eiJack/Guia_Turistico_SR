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

  Stream<QuerySnapshot> carregarAvaliacoes(String pontoTuristico) {
    return FirebaseFirestore.instance
        .collection('avaliacoes')
        .doc(pontoTuristico)
        .collection('itens')
        .snapshots();
  }
}
