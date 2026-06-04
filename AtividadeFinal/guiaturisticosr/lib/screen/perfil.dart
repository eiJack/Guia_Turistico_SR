import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//-------------------------------------------
import 'package:guiaturisticosr/screen/favoritos.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? usuario = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1ED),

      appBar: AppBar(
        title: const Text("Meu Perfil"),
        backgroundColor: const Color(0xFF8B1E3F),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: usuario == null
            ? const Center(
                child: Text(
                  "Nenhum usuário logado.",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  CircleAvatar(
                    radius: 55,
                    backgroundColor: const Color(0xFF8B1E3F),
                    backgroundImage: usuario.photoURL != null
                        ? NetworkImage(usuario.photoURL!)
                        : null,
                    child: usuario.photoURL == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          )
                        : null,
                  ),

                  const SizedBox(height: 25),

                  Text(
                    usuario.displayName ?? "Usuário",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B1E3F),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    usuario.email ?? "E-mail não disponível",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 35),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.favorite,
                        color: Color(0xFF8B1E3F),
                      ),
                      title: const Text("Favoritos"),
                      subtitle: const Text("Veja seus locais salvos no app"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FavoritosScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.star, color: Color(0xFF8B1E3F)),
                      title: Text("Avaliações"),
                      subtitle: Text("Suas avaliações de pontos turísticos"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
