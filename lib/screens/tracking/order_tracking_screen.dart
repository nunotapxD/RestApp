import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  
  // Coordenadas fixas para exemplo
  final LatLng _restaurantLocation = const LatLng(41.1579, -8.6291);
  final LatLng _deliveryLocation = const LatLng(41.1609, -8.6261);
  final LatLng _driverLocation = const LatLng(41.1589, -8.6281);

  const OrderTrackingScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acompanhar Pedido'),
      ),
      body: Column(
        children: [
          // Status banner
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange,
            child: Row(
              children: const [
                Icon(Icons.delivery_dining, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pedido a caminho',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tempo estimado: 15-20 min',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Mapa
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _driverLocation,
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    // Restaurante
                    Marker(
                      point: _restaurantLocation,
                      width: 40,
                      height: 40,
                      child: _buildMarker(Icons.restaurant, Colors.orange),
                    ),
                    // Entregador
                    Marker(
                      point: _driverLocation,
                      width: 40,
                      height: 40,
                      child: _buildMarker(Icons.delivery_dining, Colors.blue),
                    ),
                    // Destino
                    Marker(
                      point: _deliveryLocation,
                      width: 40,
                      height: 40,
                      child: _buildMarker(Icons.location_on, Colors.red),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [_restaurantLocation, _driverLocation, _deliveryLocation],
                      color: Colors.orange,
                      strokeWidth: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Timeline
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Status do Pedido',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTimelineItem(
                  'Pedido Confirmado',
                  'Restaurante recebeu seu pedido',
                  Icons.check_circle,
                  Colors.green,
                  true,
                  isFirst: true,
                ),
                _buildTimelineItem(
                  'Em Preparação',
                  'Seu pedido está sendo preparado',
                  Icons.restaurant,
                  Colors.orange,
                  true,
                ),
                _buildTimelineItem(
                  'Saiu para Entrega',
                  'Entregador a caminho',
                  Icons.delivery_dining,
                  Colors.blue,
                  true,
                ),
                _buildTimelineItem(
                  'Entregue',
                  'Pedido entregue com sucesso',
                  Icons.home,
                  Colors.grey,
                  false,
                  isLast: true,
                ),
              ],
            ),
          ),
          
          // Botão de contato com entregador
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () {
                  _showContactOptions(context);
                },
                icon: const Icon(Icons.message),
                label: const Text('Contatar Entregador'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildTimelineItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    bool isCompleted, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted ? color : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? Colors.orange : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? Colors.white : Colors.grey,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.message, color: Colors.orange),
              title: const Text('Enviar Mensagem'),
              onTap: () {
                Navigator.pop(context);
                // Implementar chat
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.orange),
              title: const Text('Ligar para Entregador'),
              onTap: () {
                Navigator.pop(context);
                // Implementar chamada
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.orange),
              title: const Text('Suporte'),
              onTap: () {
                Navigator.pop(context);
                // Implementar suporte
              },
            ),
          ],
        ),
      ),
    );
  }
}