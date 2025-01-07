import 'package:flutter/material.dart';
import '../../widgets/restaurant_card.dart';
import '../../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Mock data para demonstração
  static const List<Map<String, dynamic>> mockRestaurants = [
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
                      const Text(
                        'Descubra o restaurante ideal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Stories/Updates section
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            UpdateStory(
                              imageUrl: 'assets/images/update1.jpg',
                              title: 'Promoções',
                            ),
                            UpdateStory(
                              imageUrl: 'assets/images/update2.jpg',
                              title: 'Novidades',
                            ),
                            UpdateStory(
                              imageUrl: 'assets/images/update3.jpg',
                              title: 'Trending',
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      const Text(
                        'Restaurantes próximos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Restaurantes
                      ...mockRestaurants.map((restaurant) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RestaurantCard(
                          name: restaurant['name'],
                          imageUrl: restaurant['imageUrl'],
                          rating: restaurant['rating'],
                          distance: restaurant['distance'],
                          deliveryTime: restaurant['deliveryTime'],
                          tags: List<String>.from(restaurant['tags']),
                        ),
                      )).toList(),
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
        onTap: (index) {},
      ),
    );
  }
}

class UpdateStory extends StatelessWidget {
  final String imageUrl;
  final String title;

  const UpdateStory({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

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
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}