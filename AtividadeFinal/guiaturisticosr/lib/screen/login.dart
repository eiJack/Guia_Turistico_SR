import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  //-----------------------------------------------------------
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F1ED),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5B1731)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Color(0xFF5B1731), //cor da borda
                      width: 3,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 15,
                        offset: Offset(10, 10),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/guiaturisticosrSemfundo.png',
                    width: 260,
                  ),
                ),

                const SizedBox(height: 10),

                // TÍTULO
                const Text(
                  'Bem-vindo',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5B1731),
                  ),
                ),

                const SizedBox(height: 05),

                const Text(
                  'Explore,favorite, avalie e salve as rotas do vinho de São Roque',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),

                const SizedBox(height: 20),

                // EMAIL
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true, //tem fundo
                      fillColor: Colors.white, //cor do fundo
                      //tamanho do campo
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // SENHA
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white,

                      contentPadding: const EdgeInsets.symmetric(vertical: 10),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // BOTÃO
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5, //30%da tela
                  height: 40,

                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5B1731),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),

                      elevation: 6,
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),

                        side: const BorderSide(color: Colors.black12),
                      ),
                    ),

                    icon: Image.asset(
                      'assets/images/google.png',
                      width: 44,
                      height: 44,
                    ),

                    label: const Text(
                      'Entrar com Google',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                TextButton(
                  onPressed: () {},

                  child: const Text(
                    'Criar conta',
                    style: TextStyle(color: Color(0xFF5B1731)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
