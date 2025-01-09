import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Procurar pedidos',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                fillColor: const Color(0xFF1E1E1E),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Order List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _DateHeader(date: 'Hoje'),
                _OrderHistoryItem(
                  restaurantName: 'Mister Churrasco',
                  orderNumber: '#1234',
                  items: ['1x Picanha', '2x Refrigerante'],
                  total: 129.80,
                  time: '14:30',
                  status: OrderStatus.delivered,
                ),
                
                _DateHeader(date: 'Ontem'),
                _OrderHistoryItem(
                  restaurantName: 'Tasquinha Europa',
                  orderNumber: '#1233',
                  items: ['1x Bacalhau', '1x Vinho'],
                  total: 89.90,
                  time: '20:15',
                  status: OrderStatus.delivered,
                ),
                
                _DateHeader(date: '12 Janeiro'),
                _OrderHistoryItem(
                  restaurantName: 'Pizza Express',
                  orderNumber: '#1232',
                  items: ['1x Pizza Grande', '1x Coca-Cola'],
                  total: 75.50,
                  time: '19:45',
                  status: OrderStatus.cancelled,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index != 2) {
            final routes = ['/home', '/saved', '/history', '/profile'];
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }
}

enum OrderStatus {
  delivered,
  cancelled,
  inProgress,
}

class _DateHeader extends StatelessWidget {
  final String date;

  const _DateHeader({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        date,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _OrderHistoryItem extends StatelessWidget {
  final String restaurantName;
  final String orderNumber;
  final List<String> items;
  final double total;
  final String time;
  final OrderStatus status;

  const _OrderHistoryItem({
    Key? key,
    required this.restaurantName,
    required this.orderNumber,
    required this.items,
    required this.total,
    required this.time,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // Header
          ListTile(
            title: Row(
              children: [
                Text(
                  restaurantName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  orderNumber,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: _buildStatusChip(),
          ),

          const Divider(color: Colors.grey),

          // Order Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        item,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '€ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Navegar para detalhes do pedido
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.orange),
                        ),
                        child: const Text(
                          'Ver Detalhes',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Repetir pedido
                        },
                        child: const Text('Pedir Novamente'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    Color color;
    String text;

    switch (status) {
      case OrderStatus.delivered:
        color = Colors.green;
        text = 'Entregue';
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        text = 'Cancelado';
        break;
      case OrderStatus.inProgress:
        color = Colors.orange;
        text = 'Em andamento';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}