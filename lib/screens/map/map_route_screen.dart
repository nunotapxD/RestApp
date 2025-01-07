import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRouteScreen extends StatefulWidget {
  const MapRouteScreen({Key? key}) : super(key: key);

  @override
  State<MapRouteScreen> createState() => _MapRouteScreenState();
}

class _MapRouteScreenState extends State<MapRouteScreen> {
  GoogleMapController? _mapController;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  // Coordenadas simuladas para Porto, Portugal
  static const LatLng _userLocation = LatLng(41.1579, -8.6291);
  static const LatLng _restaurantLocation = LatLng(41.1609, -8.6261);

  @override
  void initState() {
    super.initState();
    _setRouteAndMarkers();
  }

  void _setRouteAndMarkers() {
    // Rota simulada
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: const [
          _userLocation,
          LatLng(41.1589, -8.6281),
          LatLng(41.1599, -8.6271),
          _restaurantLocation,
        ],
        color: Colors.orange,
        width: 4,
      ),
    );

    // Marcadores
    _markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: _userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Sua localização'),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('restaurant'),
        position: _restaurantLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: const InfoWindow(title: 'Mister Churrasco'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _userLocation,
              zoom: 15,
            ),
            polylines: _polylines,
            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
          ),
          // Botão Voltar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          // Card de informações da rota
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.restaurant, color: Colors.orange),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mister Churrasco',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rua Da Maia, Porto, Portugal',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _RouteInfo(
                        icon: Icons.directions_walk,
                        title: 'Distância',
                        value: '1.2 km',
                      ),
                      _RouteInfo(
                        icon: Icons.access_time,
                        title: 'Tempo est.',
                        value: '15 min',
                      ),
                      _RouteInfo(
                        icon: Icons.security,
                        title: 'Segurança',
                        value: 'Alta',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Iniciar navegação
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Iniciando navegação...'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Iniciar Navegação'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _RouteInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}