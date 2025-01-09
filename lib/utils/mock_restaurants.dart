// lib/utils/mock_restaurants.dart

class MockRestaurants {
  static final List<Map<String, dynamic>> data = [
    {
      'id': '1',
      'name': 'Mister Churrasco',
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
      'rating': 4.5,
      'reviewCount': 150,
      'distance': '1.2 km',
      'deliveryTime': '30-45 min',
      'priceLevel': '\$\$',
      'tags': ['Churrasco', 'Brasileira'],
      'isOpen': true,
      'isFavorite': false,
      'cuisine': 'Brasileira',
      'menu': {
        'destaques': [
          {
            'id': '101',
            'name': 'Picanha na Brasa',
            'description': 'Picanha grelhada com arroz, farofa e vinagrete',
            'price': 89.90,
            'imageUrl': 'https://images.unsplash.com/photo-1615937657715-bc7b4b7962c1',
            'isPopular': true,
          },
        ],
        'pratos': [
          {
            'id': '102',
            'name': 'Costela Premium',
            'description': 'Costela assada lentamente com temperos especiais',
            'price': 79.90,
            'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947',
            'isPopular': true,
          },
        ],
        'bebidas': [
          {
            'id': '103',
            'name': 'Caipirinha',
            'description': 'Limão, açúcar e cachaça artesanal',
            'price': 18.90,
            'imageUrl': 'https://images.unsplash.com/photo-1541546006121-5c3bc5e8c7b9',
          },
        ],
        'sobremesas': [
          {
            'id': '104',
            'name': 'Pudim',
            'description': 'Pudim de leite cremoso com calda de caramelo',
            'price': 15.90,
            'imageUrl': 'https://images.unsplash.com/photo-1551024506-0bccd828d307',
          },
        ],
      },
    },
    {
      'id': '2',
      'name': 'Tasquinha Europa',
      'imageUrl': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      'rating': 4.3,
      'reviewCount': 120,
      'distance': '0.8 km',
      'deliveryTime': '25-40 min',
      'priceLevel': '\$\$\$',
      'tags': ['Portuguesa', 'Tradicional'],
      'isOpen': true,
      'isFavorite': false,
      'cuisine': 'Portuguesa',
      'menu': {
        'destaques': [
          {
            'id': '201',
            'name': 'Bacalhau à Brás',
            'description': 'Bacalhau desfiado com batatas palha e ovos',
            'price': 85.90,
            'imageUrl': 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58',
            'isPopular': true,
          },
        ],
        'pratos': [
          {
            'id': '202',
            'name': 'Francesinha',
            'description': 'Sanduíche típico do Porto com molho especial',
            'price': 65.90,
            'imageUrl': 'https://images.unsplash.com/photo-1428660386617-8d277e7deaf2',
            'isPopular': true,
          },
        ],
        'bebidas': [
          {
            'id': '203',
            'name': 'Vinho do Porto',
            'description': 'Taça de vinho do Porto',
            'price': 22.90,
            'imageUrl': 'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3',
          },
        ],
        'sobremesas': [
          {
            'id': '204',
            'name': 'Pastel de Nata',
            'description': 'Tradicional pastel de nata português',
            'price': 8.90,
            'imageUrl': 'https://images.unsplash.com/photo-1577003811926-53b288a6e5d0',
          },
        ],
      },
    },
    {
      'id': '3',
      'name': 'Pizza Express',
      'imageUrl': 'https://images.unsplash.com/photo-1579751626657-72bc17010498',
      'rating': 4.7,
      'reviewCount': 200,
      'distance': '0.5 km',
      'deliveryTime': '20-35 min',
      'priceLevel': '\$\$',
      'tags': ['Pizza', 'Italiana'],
      'isOpen': true,
      'isFavorite': false,
      'cuisine': 'Italiana',
      'menu': {
        'destaques': [
          {
            'id': '301',
            'name': 'Pizza Margherita',
            'description': 'Molho de tomate, mussarela e manjericão',
            'price': 55.90,
            'imageUrl': 'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca',
            'isPopular': true,
          },
        ],
        'pratos': [
          {
            'id': '302',
            'name': 'Calzone',
            'description': 'Recheado com presunto, queijo e cogumelos',
            'price': 49.90,
            'imageUrl': 'https://images.unsplash.com/photo-1536964549204-cce9eab227bd',
            'isPopular': true,
          },
        ],
        'bebidas': [
          {
            'id': '303',
            'name': 'Vinho Chianti',
            'description': 'Taça de vinho tinto Chianti',
            'price': 25.90,
            'imageUrl': 'https://images.unsplash.com/photo-1553361371-9b22f78e8b1d',
          },
        ],
        'sobremesas': [
          {
            'id': '304',
            'name': 'Tiramisu',
            'description': 'Clássica sobremesa italiana',
            'price': 19.90,
            'imageUrl': 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9',
          },
        ],
      },
    },
  ];

  // Método auxiliar para encontrar um restaurante por ID
  static Map<String, dynamic>? findById(String id) {
    try {
      return data.firstWhere((restaurant) => restaurant['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // Método auxiliar para filtrar restaurantes
  static List<Map<String, dynamic>> filterByRating(double minRating) {
    return data.where((restaurant) => restaurant['rating'] >= minRating).toList();
  }

  // Método auxiliar para obter menu de um restaurante
  static Map<String, dynamic>? getMenu(String restaurantId) {
    final restaurant = findById(restaurantId);
    return restaurant?['menu'];
  }
}