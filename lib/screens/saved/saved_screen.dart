import 'package:flutter/material.dart';
import '../../widgets/restaurant_card.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../utils/mock_restaurants.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Map<String, dynamic>> _savedRestaurants = [];
  String _selectedFilter = 'Recentes';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Simular restaurantes salvos (em um app real, isso viria do backend/storage)
_savedRestaurants = List.from(MockRestaurants.data.where((r) => r['rating'] >= 4.5));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _removeFromFavorites(int index) {
    setState(() {
      final removed = _savedRestaurants.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${removed['name']} removido dos favoritos'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {
              setState(() {
                _savedRestaurants.insert(index, removed);
              });
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salvos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Procurar restaurantes salvos',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Filter Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterTab('Recentes'),
                const SizedBox(width: 16),
                _buildFilterTab('Restaurantes'),
              ],
            ),
          ),

          // Restaurant List
          Expanded(
            child: _savedRestaurants.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Nenhum restaurante salvo',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _savedRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = _savedRestaurants[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RestaurantCard(
                          id: restaurant['id'],
                          name: restaurant['name'],
                          imageUrl: restaurant['imageUrl'],
                          rating: restaurant['rating'],
                          reviewCount: restaurant['reviewCount'],
                          distance: restaurant['distance'],
                          deliveryTime: restaurant['deliveryTime'],
                          priceLevel: restaurant['priceLevel'],
                          tags: List<String>.from(restaurant['tags']),
                          isOpen: restaurant['isOpen'],
                          isFavorite: true,
                          onFavoritePressed: () => _removeFromFavorites(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) {
            final routes = ['/home', '/saved', '/history', '/profile'];
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }

  Widget _buildFilterTab(String title) {
    final isSelected = _selectedFilter == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}