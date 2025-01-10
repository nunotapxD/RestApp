import 'package:flutter/material.dart';
import '../../widgets/restaurant_card.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../utils/mock_restaurants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _restaurants = [];

  @override
  void initState() {
    super.initState();
_restaurants = List.from(MockRestaurants.data);
  }

  void _toggleFavorite(String id) {
    setState(() {
      final index = _restaurants.indexWhere((r) => r['id'] == id);
      if (index != -1) {
        _restaurants[index]['isFavorite'] = !_restaurants[index]['isFavorite'];
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _restaurants[index]['isFavorite']
                  ? 'Restaurante adicionado aos favoritos'
                  : 'Restaurante removido dos favoritos',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header com localização
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.orange),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Rua Da Maia, Porto, Portugal',
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFF1E1E1E),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/search'),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Procure seu restaurante favorito...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                        
                      const SizedBox(height: 20),
                      const Text(
                        'Restaurantes:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Restaurantes
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = _restaurants[index];
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
                              isFavorite: restaurant['isFavorite'],
                              onFavoritePressed: () => _toggleFavorite(restaurant['id']),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index != 0) {
            final routes = ['/home', '/saved', '/history', '/profile'];
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }
}

class UpdateStory extends StatelessWidget {
  final String imageUrl;
  final String title;

  const UpdateStory({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}