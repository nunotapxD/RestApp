import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapRouteScreen extends StatefulWidget {
  @override
  _MapRouteScreenState createState() => _MapRouteScreenState();
}

class _MapRouteScreenState extends State<MapRouteScreen> {
  static final LatLng _startLocation = LatLng(41.1579, -8.6291);
  static final LatLng _endLocation = LatLng(41.1609, -8.6261);
  final mapController = MapController();

  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _routePoints = [
      _startLocation,
      LatLng(41.1589, -8.6281),
      LatLng(41.1599, -8.6271),
      _endLocation,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rota Mais Segura'),
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () {
              // Show map style options
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: _startLocation,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': 'pk.eyJ1IjoibnVub3RhcCIsImEiOiJjbTFrcWJvdjMwMHdjMmlxeGpqM2xyMnl2In0.Vu-mWPPthAqJ7E5tibNlig',
                },
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: Colors.orange,
                    strokeWidth: 4.0,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  // Start marker
                  Marker(
                    point: _startLocation,
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  // End marker
                  Marker(
                    point: _endLocation,
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.orange,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RouteInfoHeader(),
                  SizedBox(height: 16),
                  RouteInfoStats(),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Start navigation
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text('Iniciar Navegação'),
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

class RouteInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.orange),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mister Churrasco',
                style: TextStyle(
                  color: Colors.white,
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
    );
  }
}

class RouteInfoStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RouteInfoCard(
          icon: Icons.directions_walk,
          title: 'Distância',
          value: '1.2 km',
        ),
        RouteInfoCard(
          icon: Icons.access_time,
          title: 'Tempo estimado',
          value: '15 min',
        ),
        RouteInfoCard(
          icon: Icons.security,
          title: 'Segurança',
          value: 'Alta',
        ),
      ],
    );
  }
}

class RouteInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const RouteInfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}