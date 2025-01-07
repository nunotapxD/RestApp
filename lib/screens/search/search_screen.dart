import 'package:flutter/material.dart';
import '../../widgets/restaurant_card.dart';
import '../../widgets/custom_bottom_nav.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Todos';

  final List<String> _filters = [
    'Todos',
    'Mais próximos',
    'Melhor avaliados',
    'Mais rápidos',
    'Promoções',
  ];

  // Mock data para demonstração
  final List<Map<String, dynamic>> _restaurants = [
    {
      'name': 'Mister Churrasco',
      'imageUrl': 'assets/images/restaurant1.jpg',
      'rating': 4.5,
      'distance': '1.2 km',
      'deliveryTime': '30-45 min',
      'tags': ['Churrasco', 'Brasileira'],
    },
    {
      'name': 'Tasquinha Europa',
      'imageUrl': 'assets/images/restaurant2.jpg',
      'rating': 4.3,
      'distance': '0.8 km',
      'deliveryTime': '25-40 min',
      'tags': ['Portuguesa', 'Tradicional'],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar with Filter
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar restaurantes...',
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
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.orange),
                    onPressed: () {
                      // Mostrar modal de filtros
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: const Color(0xFF1E1E1E),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => _buildFilterModal(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Filter Chips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: _selectedFilter == filter,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: const Color(0xFF1E1E1E),
                    selectedColor: Colors.orange,
                    labelStyle: TextStyle(
                      color: _selectedFilter == filter
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),

          // Results
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = _restaurants[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RestaurantCard(
                    name: restaurant['name'],
                    imageUrl: restaurant['imageUrl'],
                    rating: restaurant['rating'],
                    distance: restaurant['distance'],
                    deliveryTime: restaurant['deliveryTime'],
                    tags: List<String>.from(restaurant['tags']),
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

  Widget _buildFilterModal() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filtros',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _filters.map((filter) {
              return FilterChip(
                label: Text(filter),
                selected: _selectedFilter == filter,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                  Navigator.pop(context);
                },
                backgroundColor: const Color(0xFF2E2E2E),
                selectedColor: Colors.orange,
                labelStyle: TextStyle(
                  color: _selectedFilter == filter
                      ? Colors.white
                      : Colors.grey,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Aplicar Filtros'),
            ),
          ),
        ],
      ),
    );
  }
}