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
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Procurar no histórico',
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

          // History List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _DateHeader(date: 'Hoje'),
                HistoryItem(
                  restaurantName: 'Mister Churrasco',
                  imageUrl: 'assets/images/restaurant1.jpg',
                  items: ['1x Picanha', '2x Refrigerante'],
                  total: 129.80,
                  time: '14:30',
                  status: OrderStatus.delivered,
                ),
                
                _DateHeader(date: 'Ontem'),
                HistoryItem(
                  restaurantName: 'Tasquinha Europa',
                  imageUrl: 'assets/images/restaurant2.jpg',
                  items: ['1x Bacalhau', '1x Vinho'],
                  total: 89.90,
                  time: '20:15',
                  status: OrderStatus.delivered,
                ),
                
                _DateHeader(date: '12 Janeiro'),
                HistoryItem(
                  restaurantName: 'Mister Churrasco',
                  imageUrl: 'assets/images/restaurant1.jpg',
                  items: ['1x Costela', '1x Cerveja'],
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
        onTap: (index) {},
      ),
    );
  }
}

enum OrderStatus {
  delivered,
  cancelled,
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

class HistoryItem extends StatelessWidget {
  final String restaurantName;
  final String imageUrl;
  final List<String> items;
  final double total;
  final String time;
  final OrderStatus status;

  const HistoryItem({
    Key? key,
    required this.restaurantName,
    required this.imageUrl,
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
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              restaurantName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == OrderStatus.delivered
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status == OrderStatus.delivered ? 'Entregue' : 'Cancelado',
                style: TextStyle(
                  color: status == OrderStatus.delivered
                      ? Colors.green
                      : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
                      'R\$ ${total.toStringAsFixed(2)}',
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
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
}