import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:guiaturisticosr/model/avaliacao.dart';

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

  void enviarAvaliacao() {
    if (nota == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Selecione uma nota antes de enviar.')));
      return;
    }

    setState(() {
      avaliacoes.add(
        Avaliacao(
          nomeUsuario: "Cristiane",
          fotoUsuario: "https://i.pravatar.cc/150?img=5",
          nota: nota,
          comentario: comentarioController.text,
          fotoAvaliacao: foto?.path,
        ),
      );

      comentarioController.clear();
      nota = 0;
      foto = null;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Avaliação enviada com sucesso!')));
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

                  if (avaliacoes.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text("Nenhuma avaliação cadastrada."),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: avaliacoes.length,
                      itemBuilder: (context, index) {
                        final avaliacao = avaliacoes[index];

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
                                      backgroundImage: NetworkImage(avaliacao.fotoUsuario),
                                    ),

                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Text(
                                        avaliacao.nomeUsuario,
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
                                      i < avaliacao.nota ? Icons.star : Icons.star_border,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Text(avaliacao.comentario),

                                if (avaliacao.fotoAvaliacao != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        File(avaliacao.fotoAvaliacao!),
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
