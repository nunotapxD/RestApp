import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../providers/cart_provider.dart';
import '../../models/dish.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  void _reorderItems(BuildContext context, List<Map<String, dynamic>> items) {
    // Adicionar itens ao carrinho
    final cartProvider = context.read<CartProvider>();
    
    for (var item in items) {
      final dish = Dish(
        id: item['id'] ?? DateTime.now().toString(),
        name: item['name'],
        description: '',
        price: item['price'],
        imageUrl: '',
      );
      
      for (int i = 0; i < item['quantity']; i++) {
        cartProvider.addToCart(dish);
      }
    }

    // Navegação para o carrinho
    Navigator.pushReplacementNamed(context, '/cart');

    // Mostrar confirmação
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Itens adicionados ao carrinho'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDateHeader('Hoje'),
                _buildOrderHistoryItem(
                  context,
                  restaurantName: 'Mister Churrasco',
                  orderNumber: '#1234',
                  items: [
                    {'id': 'p1', 'name': 'Picanha na Brasa', 'quantity': 2, 'price': 89.90},
                    {'id': 'b1', 'name': 'Refrigerante', 'quantity': 2, 'price': 5.90}
                  ],
                  total: 189.70,
                  time: '14:30',
                  status: OrderStatus.delivered,
                ),
                
                _buildDateHeader('Ontem'),
                _buildOrderHistoryItem(
                  context,
                  restaurantName: 'Tasquinha Europa',
                  orderNumber: '#1233',
                  items: [
                    {'id': 'b1', 'name': 'Bacalhau à Brás', 'quantity': 1, 'price': 85.90},
                    {'id': 'b2', 'name': 'Vinho do Porto', 'quantity': 1, 'price': 22.90}
                  ],
                  total: 108.80,
                  time: '20:15',
                  status: OrderStatus.delivered,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index != 3) {
            final routes = ['/home', '/cart', '/saved', '/history', '/profile'];
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }

  Widget _buildDateHeader(String date) {
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

  Widget _buildOrderHistoryItem(
    BuildContext context, {
    required String restaurantName,
    required String orderNumber,
    required List<Map<String, dynamic>> items,
    required double total,
    required String time,
    required OrderStatus status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
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
            trailing: _buildStatusChip(status),
          ),

          const Divider(color: Colors.grey),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${item['quantity']}x ${item['name']}',
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
                      '€${total.toStringAsFixed(2)}',
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
                        onPressed: () => _showOrderDetails(context, orderNumber, items, total, status),
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
                        onPressed: () => _reorderItems(context, items),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
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

  Widget _buildStatusChip(OrderStatus status) {
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

  void _showOrderDetails(
    BuildContext context,
    String orderNumber,
    List<Map<String, dynamic>> items,
    double total,
    OrderStatus status,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text('Pedido $orderNumber'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Itens do Pedido:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('${item['quantity']}x ${item['name']}'),
            )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:'),
                Text(
                  '€${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

enum OrderStatus {
  delivered,
  cancelled,
  inProgress,
}