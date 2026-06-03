// cadastra os locais
import '../model/ponto_turistico_model.dart';

class PontosService {
  List<PontosTuristicos> listarPontos() {
    return [
      // ROTA DO VINHO
      PontosTuristicos(
        nome: 'Villa Don Patto',
        categoria: 'Rota do Vinho',
        rotaDoVinho: true,
        latitude: -23.5636425,
        longitude: -47.1357421,
        descricao: 'Complexo gastronômico e turístico.',
      ),

      PontosTuristicos(
        nome: 'Vinícola XV de Novembro',
        categoria: 'Rota do Vinho',
        rotaDoVinho: true,
        latitude: -23.5837880,
        longitude: -47.1419250,
        descricao: 'Vinícola tradicional da região.',
      ),

      PontosTuristicos(
        nome: 'Bella Aurora',
        categoria: 'Rota do Vinho',
        rotaDoVinho: false,
        latitude: -23.5400,
        longitude: -47.1420,
        descricao: 'Vinhos, adega e gastronomia.',
      ),

      PontosTuristicos(
        nome: 'Cantina Tia Lina',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.6124258,
        longitude: -47.1559355,
        descricao: 'Cantina italiana tradicional.',
      ),
      PontosTuristicos(
        nome: 'Restaurante Recanto Nordestino',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.5290,
        longitude: -47.1380,
        descricao:
            'Restaurante nordestino com buffet à vontade e pratos típicos.',
      ),

      // RESTAURANTES
      PontosTuristicos(
        nome: 'O Cortês Bar e Restaurante',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.5300,
        longitude: -47.1350,
        descricao: 'Restaurante e bar em São Roque.',
      ),

      PontosTuristicos(
        nome: 'Taki Sushi',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.5750715,
        longitude: -47.1387187,
        descricao: 'Culinária japonesa.',
      ),

      // HOTÉIS
      PontosTuristicos(
        nome: 'NÓR Hotel & Spa',
        categoria: 'Hotel',
        rotaDoVinho: false,
        latitude: -23.5728,
        longitude: -47.1735,
        descricao: 'Hotel e spa em São Roque.',
      ),

      PontosTuristicos(
        nome: 'Hotel Stefano',
        categoria: 'Hotel',
        rotaDoVinho: false,
        latitude: -23.55089,
        longitude: -47.10196,
        descricao: 'Hotel tradicional da cidade.',
      ),

      PontosTuristicos(
        nome: 'Restaurante Stefano',
        categoria: 'Restaurante',
        rotaDoVinho: false,
        latitude: -23.55089,
        longitude: -47.10196,
        descricao: 'Restaurante anexo ao hotel Stefano.',
      ),

      // TURISMO
      PontosTuristicos(
        nome: 'Morro do Saboó',
        categoria: 'Ponto turistico',
        rotaDoVinho: false,
        latitude: -23.5065,
        longitude: -47.0826,
        descricao: 'Trilhas, natureza e mirantes.',
      ),

      PontosTuristicos(
        nome: 'Centro Cultural Brasital',
        categoria: 'Ponto turistico',
        rotaDoVinho: false,
        latitude: -23.5305,
        longitude: -47.1355,
        descricao: 'Centro cultural de São Roque.',
      ),

      PontosTuristicos(
        nome: 'Ski Mountain Park',
        categoria: 'Ponto turistico',
        rotaDoVinho: false,
        latitude: -23.506316,
        longitude: -47.11695,
        descricao: 'Parque de lazer e aventura.',
      ),
    ];
  }
}
