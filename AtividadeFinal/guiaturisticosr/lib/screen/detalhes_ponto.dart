import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:guiaturisticosr/model/avaliacao.dart';
import 'package:guiaturisticosr/service/avaliacao_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DetalhesPonto extends StatefulWidget {
  final String nome;
  final String imagem;
  final String descricao;
  final String telefone;
  final String endereco;
  final String whatsapp;

  const DetalhesPonto({
    super.key,
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.telefone,
    required this.endereco,
    required this.whatsapp,
  });

  @override
  State<DetalhesPonto> createState() => _DetalhesPontoState();
}

class _DetalhesPontoState extends State<DetalhesPonto> {
  int nota = 0;

  final TextEditingController comentarioController = TextEditingController();

  File? foto;

  // Lista de avaliações
  final List<Avaliacao> avaliacoes = [];

  Future<void> tirarFoto() async {
    final picker = ImagePicker();

    final imagem = await picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    if (imagem != null) {
      setState(() {
        foto = File(imagem.path);
      });
    }
  }

  Future<void> enviarAvaliacao() async {
    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Faça login para enviar uma avaliação.')));
      return;
    }

    String? fotoUrl;

    if (foto != null) {
      print('Iniciando upload...');

      final storageRef = FirebaseStorage.instance.ref().child(
        'avaliacoes/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      print('Caminho: ${storageRef.fullPath}');

      await storageRef.putFile(foto!);

      print('Upload concluído');

      fotoUrl = await storageRef.getDownloadURL();

      print('URL: $fotoUrl');
    }
    final avaliacao = Avaliacao(
      nomeUsuario: FirebaseAuth.instance.currentUser?.displayName ?? "Usuário",
      fotoUsuario: FirebaseAuth.instance.currentUser?.photoURL ?? "https://i.pravatar.cc/150?img=5",
      nota: nota,
      comentario: comentarioController.text,
      fotoAvaliacao: fotoUrl, // agora salva a URL da foto
    );

    await AvaliacaoService().salvarAvaliacao(widget.nome, avaliacao);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Avaliação salva no Firebase!')));

      comentarioController.clear();
      setState(() {
        nota = 0;
        foto = null;
      });
    }
  }

  Future<void> ligarTelefone() async {
    final uri = Uri.parse('tel:${widget.telefone}');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> abrirWhatsapp() async {
    final numero = widget.whatsapp
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll(" ", "");

    final uri = Uri.parse('https://wa.me/55$numero');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nome)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.imagem, width: double.infinity, height: 250, fit: BoxFit.cover),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nome,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(widget.descricao, style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Expanded(child: Text(widget.endereco)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 8),
                      Text(widget.telefone),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: ligarTelefone,
                          icon: const Icon(Icons.phone),
                          label: const Text("Ligar"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: abrirWhatsapp,
                          icon: const Icon(Icons.chat),
                          label: const Text("WhatsApp"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Divider(),

                  const SizedBox(height: 15),

                  const Text(
                    "Avaliações",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: Icon(
                          index < nota ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 35,
                        ),
                        onPressed: () {
                          setState(() {
                            nota = index + 1;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: comentarioController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Comentário",
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton.icon(
                    onPressed: tirarFoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Tirar Foto"),
                  ),

                  if (foto != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          foto!,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: enviarAvaliacao,
                      icon: const Icon(Icons.send),
                      label: const Text("Enviar Avaliação"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Comentários dos visitantes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  StreamBuilder<QuerySnapshot>(
                    stream: AvaliacaoService().carregarAvaliacoes(widget.nome),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Text('Erro: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text("Nenhuma avaliação cadastrada."));
                      }

                      final avaliacoes = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: avaliacoes.length,
                        itemBuilder: (context, index) {
                          final dados = avaliacoes[index].data() as Map<String, dynamic>;

                          return Card(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(dados['fotoUsuario']),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          dados['nomeUsuario'],
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        i < dados['nota'] ? Icons.star : Icons.star_border,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(dados['comentario']),
                                  if (dados['fotoAvaliacao'] != null &&
                                      dados['fotoAvaliacao'].isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          dados['fotoAvaliacao'],
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
