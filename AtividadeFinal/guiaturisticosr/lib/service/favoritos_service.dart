import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritosService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> listarFavoritos() {
    return _firestore.collection('usuarios').doc(uid).collection('favoritos').snapshots();
  }

  Future<void> adicionarFavorito({
    required String nome,
    required String imagem,
    required String descricao,
  }) async {
    await _firestore.collection('usuarios').doc(uid).collection('favoritos').doc(nome).set({
      'nome': nome,
      'imagem': imagem,
      'descricao': descricao,
    });
  }

  Future<void> removerFavorito(String nome) async {
    await _firestore.collection('usuarios').doc(uid).collection('favoritos').doc(nome).delete();
  }

  Future<bool> isFavorito(String nome) async {
    final doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('favoritos')
        .doc(nome)
        .get();

    return doc.exists;
  }
}
