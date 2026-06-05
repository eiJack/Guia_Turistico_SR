import 'package:guiaturisticosr/service/conexao_service.dart';
import 'package:guiaturisticosr/screen/login.dart';
import 'package:guiaturisticosr/screen/mapa.dart';
import 'package:guiaturisticosr/screen/favoritos.dart';
import 'package:guiaturisticosr/screen/perfil.dart';
import 'package:guiaturisticosr/screen/detalhes_ponto.dart';
import 'package:guiaturisticosr/data/pontos_turisticos.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //iniciar avaliacao de conexao
  final ConexaoService _conexaoService = ConexaoService();

  @override
  void initState() {
    super.initState();

    //executa so depois da tela toda ser construida
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _conexaoService.monitorarConexao(
        onStatusChange: (conectado) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(conectado ? 'Internet conectada' : 'Sem conexão com a internet'),
              backgroundColor: conectado ? Colors.green : Colors.red,
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _conexaoService.dispose();
    super.dispose();
  }

  //-----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //verificando se usuario esta logado
    final User? usuario = FirebaseAuth.instance.currentUser;
    final bool logado = usuario != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1ED),

      appBar: AppBar(
        title: const Text("Rota do Vinho"),
        backgroundColor: const Color(0xFF8B1E3F),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF8B1E3F)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    backgroundImage: usuario?.photoURL != null
                        ? NetworkImage(usuario!.photoURL!)
                        : null,
                    child: usuario?.photoURL == null
                        ? const Icon(Icons.person, size: 35, color: Color(0xFF8B1E3F))
                        : null,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    usuario?.displayName ?? "Visitante",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(leading: const Icon(Icons.home), title: const Text("Início"), onTap: () {}),

            ListTile(
              leading: const Icon(Icons.map),
              title: const Text("Mapa"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapaScreen()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Favoritos"),
              onTap: () {
                if (!logado) {
                  _mostrarAvisoLogin();
                  return;
                }

                Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritosScreen()));
              },
            ),

            if (logado)
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Perfil"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PerfilScreen()));
                },
              ),

            ListTile(
              leading: Icon(logado ? Icons.logout : Icons.login),
              title: Text(logado ? "Sair" : "Login"),
              onTap: () async {
                if (logado) {
                  final sair = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Sair da conta"),
                      content: const Text("Deseja realmente encerrar sua sessão?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancelar"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Sair"),
                        ),
                      ],
                    ),
                  );

                  if (sair == true) {
                    await FirebaseAuth.instance.signOut();

                    if (!mounted) return;

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("Logout realizado com sucesso")));

                    setState(() {});
                  }
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                }
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bem-vindo à Rota do Vinho 🍷",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B1E3F),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Explore vinícolas, restaurantes e experiências incríveis em São Roque.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),

              const SizedBox(height: 10),

              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1510812431401-41d2bd2722f3",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _cardMenu(
                    icon: Icons.location_on,
                    titulo: "Mapa",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MapaScreen()),
                      );
                    },
                  ),

                  _cardMenu(
                    icon: Icons.favorite,
                    titulo: "Favoritos",
                    onTap: () {
                      if (!logado) {
                        _mostrarAvisoLogin();
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FavoritosScreen()),
                      );
                    },
                  ),
                ],
              ),

              secaoCards("🍷 Rota do Vinho", rotaDoVinho, logado),

              secaoCards("🏨 Hotéis", hoteis, logado),

              secaoCards("📷 Turismo", turismo, logado),
            ],
          ),
        ),
      ),
    );
  }

  //===============CARDs dos pontos turisticos========================

  Widget cardTuristico({
    required String nome,
    required String imagem,
    required String descricao,
    required String telefone,
    required String whatsapp,
    required String endereco,
    required bool logado,
  }) {
    return GestureDetector(
      onTap: () {
        if (!logado) {
          _mostrarAvisoLogin();
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetalhesPonto(
              nome: nome,
              imagem: imagem,
              descricao: descricao,
              telefone: telefone,
              whatsapp: whatsapp,
              endereco: endereco,
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(imagem, height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 45,
                      child: Center(
                        child: Text(
                          nome,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B1E3F),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget secaoCards(String titulo, List<Map<String, String>> locais, bool logado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(titulo, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),

        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: locais.length,
            itemBuilder: (context, index) {
              final local = locais[index];

              return cardTuristico(
                nome: local["nome"] ?? "",
                imagem: local["imagem"] ?? "",
                descricao: local["descricao"] ?? "",
                telefone: local["telefone"] ?? "",
                whatsapp: local["whatsapp"] ?? "",
                endereco: local["endereco"] ?? "",
                logado: logado,
              );
            },
          ),
        ),
      ],
    );
  }

  //=============================================

  Widget _cardMenu({required IconData icon, required String titulo, VoidCallback? onTap}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: const Color(0xFF8B1E3F)),
          const SizedBox(height: 10),
          Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _mostrarAvisoLogin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login necessário"),
        content: const Text("Esta funcionalidade está disponível apenas para usuários logados."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
            },
            child: const Text("Logar"),
          ),
        ],
      ),
    );
  }
}
