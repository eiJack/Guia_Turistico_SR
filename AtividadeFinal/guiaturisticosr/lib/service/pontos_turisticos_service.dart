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
        nome: 'Quinta do Olivardo',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.57711,
        longitude: -47.13866,
        descricao:
            'Famoso complexo enogastronômico tradicional da Rota do Vinho.',
      ),

      PontosTuristicos(
        nome: 'Estilla Destilaria e Cervejaria',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.56862,
        longitude: -47.13865,
        descricao:
            'Cervejaria fundada em 1989, que se destaca por fazer vinhos, destilados e cervejas.',
      ),

      PontosTuristicos(
        nome: 'Hockenheim Cervejaria',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.59089,
        longitude: -47.14739,
        descricao:
            'Uma fábrica de cervejas artesanais de alta qualidade com um restaurante focado em cortes de carne nobres.',
      ),

      PontosTuristicos(
        nome: 'Caracol Chocolates',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.55728,
        longitude: -47.12685,
        descricao: 'Chocolateria & Cafeteria .',
      ),

      PontosTuristicos(
        nome: 'Pica Fumo Restaurante',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.55846,
        longitude: -47.12861,
        descricao: 'Restaurante tradicional de sao roque',
      ),

      PontosTuristicos(
        nome: 'Dionísio Restaurante',
        categoria: 'Restaurante',
        rotaDoVinho: true,
        latitude: -23.56221,
        longitude: -47.13199,
        descricao: 'Restaurante tradicional de sao roque',
      ),

      PontosTuristicos(
        nome: 'Vinícola Goes',
        categoria: 'Rota do Vinho',
        rotaDoVinho: true,
        latitude: -23.61079,
        longitude: -47.16019,
        descricao: 'Vinícola tradicional da região.',
      ),

      PontosTuristicos(
        nome: 'Bella Aurora',
        categoria: 'Rota do Vinho',
        rotaDoVinho: false,
        latitude: -23.55364,
        longitude: -47.10524,
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
        latitude: -23.55492,
        longitude: -47.12534,
        descricao:
            'Restaurante nordestino com buffet à vontade e pratos típicos.',
      ),

      // RESTAURANTES
      PontosTuristicos(
        nome: 'O Cortês Bar e Restaurante',
        categoria: 'Restaurante',
        rotaDoVinho: false,
        latitude: -23.52562,
        longitude: -47.13336,
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
        latitude: -23.57260,
        longitude: -47.12234,
        descricao: 'Hotel e spa em São Roque.',
      ),

      PontosTuristicos(
        nome: 'Hotel Stefano',
        categoria: 'Hotel',
        rotaDoVinho: false,
        latitude: -23.55109,
        longitude: -47.10195,
        descricao: 'Hotel tradicional da cidade.',
      ),

      PontosTuristicos(
        nome: 'Restaurante Stefano',
        categoria: 'Restaurante',
        rotaDoVinho: false,
        latitude: -23.55109,
        longitude: -47.10195,
        descricao: 'Restaurante anexo ao hotel Stefano.',
      ),

      PontosTuristicos(
        nome: 'Pousada Garden House',
        categoria: 'Hotel',
        rotaDoVinho: false,
        latitude: -23.62748,
        longitude: -47.15605,
        descricao: 'Pousada tradicional da cidade.',
      ),

      // TURISMO
      PontosTuristicos(
        nome: 'Morro do Saboó',
        categoria: 'Ponto turistico',
        rotaDoVinho: false,
        latitude: -23.47522,
        longitude: -47.16303,
        descricao: 'Trilhas, natureza e mirantes.',
      ),

      PontosTuristicos(
        nome: 'Centro Cultural Brasital',
        categoria: 'Ponto turistico',
        rotaDoVinho: false,
        latitude: -23.53338,
        longitude: -47.13101,
        descricao: 'Centro cultural de São Roque.',
      ),

      PontosTuristicos(
        nome: 'Igreja Matriz de São Roque',
        categoria: 'Ponto turistico',
        rotaDoVinho: false,
        latitude: -23.53031,
        longitude: -47.13564,
        descricao: 'Igreja matriz, tradicional da cidade.',
      ),
    ];
  }
}
