import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../service/favoritos_service.dart';
import 'package:guiaturisticosr/data/pontos_turisticos.dart';
import 'package:guiaturisticosr/screen/detalhes_ponto.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FavoritosService().listarFavoritos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum favorito encontrado'));
          }

          final favoritos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favoritos.length,
            itemBuilder: (context, index) {
              final dados = favoritos[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.asset(dados['imagem'], width: 60, fit: BoxFit.cover),
                  title: Text(dados['nome']),
                  subtitle: Text(dados['descricao'], maxLines: 2, overflow: TextOverflow.ellipsis),

                  trailing: const Icon(Icons.arrow_forward_ios),

                  onTap: () {
                    final todosOsPontos = [...rotaDoVinho, ...hoteis, ...turismo];

                    final ponto = todosOsPontos.firstWhere((p) => p['nome'] == dados['nome']);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhesPonto(
                          nome: ponto['nome'] ?? '',
                          imagem: ponto['imagem'] ?? '',
                          descricao: ponto['descricao'] ?? '',
                          telefone: ponto['telefone'] ?? '',
                          whatsapp: ponto['whatsapp'] ?? '',
                          endereco: ponto['endereco'] ?? '',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
