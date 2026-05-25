//funcionalidades assincronas do Dart - verifica mudanças continuamente
import 'dart:async';
//permite verificar rede(wifi, dados moveis) e como esta
import 'package:connectivity_plus/connectivity_plus.dart';

class ConexaoService {
  final Connectivity _connectivity =
      Connectivity(); //acessa as funcoes do pacote connectivity

  StreamSubscription<List<ConnectivityResult>>?
  subscription; //guarda o estado de conexao continuamente

  void monitorarConexao({required Function(bool conectado) onStatusChange}) {
    //boleano -> true conectado; false sem internet
    subscription = _connectivity.onConnectivityChanged.listen((resultados) {
      bool conectado = !resultados.contains(ConnectivityResult.none);

      onStatusChange(conectado);
    });
  }

  //para monitoramento quando tela é fechada
  void dispose() {
    subscription?.cancel();
  }
}
