import '../model/ponto_turistico_model.dart';
import '../service/pontos_turisticos_service.dart';

class MapaController {
  final PontosService _service = PontosService(); //puxando o service
  String categoriaSelecionada = 'Todos';

  //lista de categorias
  final List<String> categorias = [
    'Todos',
    'Rota do Vinho',
    'Restaurante',
    'Hotel',
    'Ponto turistico',
  ];

  //retora todos os pontos
  List<PontosTuristicos> todosPontos() {
    return _service.listarPontos();
  }

  List<PontosTuristicos> get pontosFiltrados {
    //mostra todos os pontos ao filtrar
    if (categoriaSelecionada == 'Todos') {
      return todosPontos();
    }

    //filtra apenas categoria escolhida
    return todosPontos().where((ponto) {
      return ponto.categoria == categoriaSelecionada;
    }).toList();
  }

  void alterarCategoria(String categoria) {
    categoriaSelecionada = categoria;
  }
}
