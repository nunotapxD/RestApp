// lib/widgets/dish_card.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../providers/cart_provider.dart';

class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({
    super.key,
    required this.dish,
  });
  void _reorderItems(BuildContext context, List<Map<String, dynamic>> items) {
    final cartProvider = context.read<CartProvider>();
    
    // Limpar carrinho atual
    cartProvider.clear();
    
    for (var item in items) {
      // Criar o objeto Dish sem o parâmetro quantity
      final dish = Dish(
        id: item['id'] ?? DateTime.now().toString(),
        name: item['name'],
        description: '',
        price: item['price'],
        imageUrl: '',
      );
      
      // Pegar a quantidade do item e adicionar ao carrinho
      final quantity = item['quantity'] as int;
      for (int i = 0; i < quantity; i++) {
        cartProvider.addToCart(dish);
      }
    }

    // Mostrar confirmação
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Itens adicionados ao carrinho'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Navegação para o carrinho
    Navigator.pushReplacementNamed(context, '/cart');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
  dish.imageUrl,
  height: 160,
  width: double.infinity,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Container(
      height: 160,
      color: Colors.grey[900],
      child: const Icon(
        Icons.restaurant,
        size: 50,
        color: Colors.grey,
      ),
    );
  },
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Container(
      height: 160,
      color: Colors.grey[900],
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );
  },
),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dish.description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R\$ ${dish.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Implementar adição ao carrinho
                      },
                      child: const Text('Adicionar'),
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