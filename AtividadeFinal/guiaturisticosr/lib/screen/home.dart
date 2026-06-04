import 'package:flutter/material.dart';
import 'package:guiaturisticosr/screen/login.dart';
import 'package:guiaturisticosr/service/conexao_service.dart';
import 'package:guiaturisticosr/screen/mapa.dart';

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
              content: Text(
                conectado ? 'Internet conectada' : 'Sem conexão com a internet',
              ),
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

  //-------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
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
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF8B1E3F)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.wine_bar, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "Rota do Vinho",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Início"),
              onTap: () {},
            ),

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
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(
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

            const SizedBox(height: 30),

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

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                _cardMenu(icon: Icons.wine_bar, titulo: "Vinícolas"),
                _cardMenu(icon: Icons.star, titulo: "Avaliações"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardMenu({
    required IconData icon,
    required String titulo,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: const Color(0xFF8B1E3F)),
            const SizedBox(height: 10),
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
