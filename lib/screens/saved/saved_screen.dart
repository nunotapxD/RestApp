import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../widgets/restaurant_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  String _selectedTab = 'Recentes';

  // Mock data para demonstração
  final List<Map<String, dynamic>> _savedRestaurants = [
    {
      'name': 'Mister Churrasco',
      'imageUrl': 'assets/images/restaurant1.jpg',
      'rating': 4.5,
      'distance': '1.2 km',
      'deliveryTime': '30-45 min',
      'tags': ['Churrasco', 'Brasileira'],
      'isOpen': true,
    },
    {
      'name': 'Tasquinha Europa',
      'imageUrl': 'assets/images/restaurant2.jpg',
      'rating': 4.3,
      'distance': '0.8 km',
      'deliveryTime': '25-40 min',
      'tags': ['Portuguesa', 'Tradicional'],
      'isOpen': false,
    },
  ];

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
                // Implementar busca
                setState(() {});
              },
            ),
          ),

          // Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _TabButton(
                  title: 'Recentes',
                  isSelected: _selectedTab == 'Recentes',
                  onTap: () => setState(() => _selectedTab = 'Recentes'),
                ),
                const SizedBox(width: 16),
                _TabButton(
                  title: 'Restaurantes',
                  isSelected: _selectedTab == 'Restaurantes',
                  onTap: () => setState(() => _selectedTab = 'Restaurantes'),
                ),
              ],
            ),
          ),

          // Saved Restaurants List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _savedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = _savedRestaurants[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RestaurantCard(
                    name: restaurant['name'],
                    imageUrl: restaurant['imageUrl'],
                    rating: restaurant['rating'],
                    distance: restaurant['distance'],
                    deliveryTime: restaurant['deliveryTime'],
                    tags: List<String>.from(restaurant['tags']),
                    isFavorite: true,
                    onFavoritePressed: () {
                      // Implementar remoção dos favoritos
                      setState(() {
                        _savedRestaurants.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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