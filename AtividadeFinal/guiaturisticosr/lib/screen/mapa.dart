import '../controller/mapa_controller.dart';
//----------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final MapaController controller = MapaController();
  final MapController mapController = MapController();

  double zoomAtual = 14;
  bool mapaPronto = false;
  LatLng? minhaLocalizacao;
  final LatLng localizacaoPadrao = LatLng(-23.554328, -47.124203);
  bool avisoForaDaRegiaoExibido = false;

  @override
  void initState() {
    super.initState();
    _pegarLocalizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    final pontos = controller.pontosFiltrados;

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de São Roque'), centerTitle: true),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: minhaLocalizacao ?? localizacaoPadrao,
              initialZoom: zoomAtual,
              minZoom: 10,
              maxZoom: 18,

              onMapReady: () {
                setState(() {
                  mapaPronto = true;
                });
              },

              onPositionChanged: (position, hasGesture) {
                zoomAtual = position.zoom;
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.guia_turistico_sr',
              ),

              MarkerLayer(
                markers: [
                  if (minhaLocalizacao != null)
                    Marker(
                      point: minhaLocalizacao!,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Color.fromARGB(255, 133, 7, 74),
                        size: 45,
                      ),
                    ),

                  ...pontos.map((ponto) {
                    return Marker(
                      point: LatLng(ponto.latitude, ponto.longitude),
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          _abrirDetalhesPonto(context, ponto);
                        },
                        child: Icon(
                          _iconPorCategoria(ponto.categoria),
                          color: _corPorCategoria(ponto.categoria),
                          size: 40,
                        ),
                      ),
                    );
                }),
              ),
            ],
          ),

          Positioned(
            top: 16,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.categorias.map((categoria) {
                final selecionado =
                    controller.categoriaSelecionada == categoria;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.alterarCategoria(categoria);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selecionado
                          ? const Color(0xFF8B1E3F)
                          : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      _iconPorCategoria(categoria),
                      color: selecionado
                          ? Colors.white
                          : const Color(0xFF8B1E3F),
                      size: 26,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 30,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'zoomIn',
                  onPressed: mapaPronto
                      ? () {
                          setState(() {
                            if (zoomAtual < 18) {
                              zoomAtual++;

                              mapController.move(
                                mapController.camera.center,
                                zoomAtual,
                              );
                            }
                          });
                        }
                      : null,
                  child: const Icon(Icons.add),
                ),

                const SizedBox(height: 10),

                FloatingActionButton.small(
                  heroTag: 'zoomOut',
                  onPressed: mapaPronto
                      ? () {
                          setState(() {
                            if (zoomAtual > 10) {
                              zoomAtual--;

                              mapController.move(
                                mapController.camera.center,
                                zoomAtual,
                              );
                            }
                          });
                        }
                      : null,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------- modal dos detalhes ---------------
  void _abrirDetalhesPonto(BuildContext context, dynamic ponto) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ponto.nome,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                ponto.categoria,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 12),

              Text(ponto.descricao, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ------------------- icone por categoria --------------
  IconData _iconPorCategoria(String categoria) {
    switch (categoria) {
      case 'Rota do Vinho':
        return Icons.wine_bar;

      case 'Restaurante':
        return Icons.restaurant;

      case 'Hotel':
        return Icons.hotel;

      case 'Ponto turistico':
        return Icons.camera_alt;

      default:
        return Icons.location_pin;
    }
  }

  //------------------ cor por categoria ------------------
  Color _corPorCategoria(String categoria) {
    switch (categoria) {
      case 'Rota do Vinho':
        return Colors.purple;

      case 'Restaurante':
        return Colors.orange;

      case 'Hotel':
        return Colors.blue;

      case 'Ponto turistico':
        return Colors.green;

      default:
        return Colors.red;
    }
  }
//-------------------pegar localizacao atual-----------------
  Future<void> _pegarLocalizacaoAtual() async {
    bool servicoAtivo;
    LocationPermission permissao;

    servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ative a localização do dispositivo.")),
      );
      return;
    }

    permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permissão de localização negada.")),
        );
        return;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permissão de localização negada permanentemente."),
        ),
      );
      return;
    }

    final Position posicao = await Geolocator.getCurrentPosition();

    if (!mounted) return;

    final LatLng localizacaoUsuario = LatLng(
      posicao.latitude,
      posicao.longitude,
    );

    final double distanciaEmMetros = Geolocator.distanceBetween(
      localizacaoUsuario.latitude,
      localizacaoUsuario.longitude,
      localizacaoPadrao.latitude,
      localizacaoPadrao.longitude,
    );

    if (distanciaEmMetros <= 20000) {
      setState(() {
        minhaLocalizacao = localizacaoUsuario;
      });

      if (mapaPronto) {
        mapController.move(minhaLocalizacao!, 15);
      }
    } else {
      setState(() {
        minhaLocalizacao = null;
      });

      if (mapaPronto) {
        mapController.move(localizacaoPadrao, 14);
      }

      if (!avisoForaDaRegiaoExibido) {
        avisoForaDaRegiaoExibido = true;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Você está fora da região de São Roque. Exibindo mapa padrão.",
            ),
          ),
        );
      }
    }
  }
}
