import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesPonto extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagem,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    descricao,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(endereco),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 10),
                      Text(telefone),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => ligar(telefone),
                          icon: const Icon(Icons.phone),
                          label: const Text("Ligar"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => abrirWhatsapp(whatsapp),
                          icon: const Icon(Icons.message),
                          label: const Text("WhatsApp"),
                        ),
                      ),
                    ],
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

Future<void> ligar(String telefone) async {
  final Uri uri = Uri(
    scheme: 'tel',
    path: telefone,
  );

  await launchUrl(uri);
}

Future<void> abrirWhatsapp(String numero) async {
  final Uri uri = Uri.parse(
    'https://wa.me/$numero',
  );

  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}